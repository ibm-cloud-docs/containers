---

copyright: 
  years: 2014, 2025
lastupdated: "2025-08-01"


keywords: kubernetes, containers, containers

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}





# CIS Kubernetes Benchmark
{: #cis-benchmark}

The Center for Internet Security (CIS) publishes the [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes/){: external} as a framework of specific steps to configure Kubernetes more securely and with standards that are commensurate to various industry regulations.
{: shortdesc}

When a new [Kubernetes version](/docs/containers?topic=containers-cs_versions) is released, IBM engineers compare the default configuration of a cluster that runs that Kubernetes version against the benchmark and publishes the results in this documentation. You can review how specific versions of your {{site.data.keyword.containerlong}} clusters meet the CIS Kubernetes Benchmark.

## Supported benchmark versions
{: #cis-benchmark-versions}

Use the list to find CIS Kubernetes Benchmark results for supported versions.
- [Version 1.33](/docs/containers?topic=containers-cis-benchmark-133)
- [Version 1.32](/docs/containers?topic=containers-cis-benchmark-132)
- [Version 1.31](/docs/containers?topic=containers-cis-benchmark-131)
- [Version 1.30](/docs/containers?topic=containers-cis-benchmark-130)





## Using the benchmark
{: #cis-benchmark-use}

As a security administrator or auditor, you might want to compare your company's internal standards and external regulatory requirements with the CIS Kubernetes Benchmark. The benchmark recommendations are provided by the Center for Internet Security, not by IBM. IBM might not configure default settings in a way that meets every recommendation, but documents whether the recommendation is met to help you in your review. For example, you might use the benchmark in an audit to confirm that basic security measures are in place, and to identify areas where you might enhance your security.
{: shortdesc}

### What does the benchmark cover?
{: #benchmark-scope}

The benchmark covers recommendations for master components, etcd, control plane configurations, worker nodes, and policies such as for users, network, and pod security. 

### What do the benchmark recommendations mean?
{: #benchmark-meaning}

The benchmark recommendations have scoring, levels, result status, and responsibilities as follows.

* **Scoring**
    * Scored: The overall benchmark score increases or decreases depending on whether the  recommendation is met.
    * Not scored: The overall benchmark score is not impacted, whether the recommendation is met.
* **Levels**
    * Level 1: Practical security measures that can be configured without inhibiting the service.
    * Level 2: More in-depth security measures that might reduce the performance or functionality of a service.
* **Result**
    * Pass: The service complies with the benchmark recommendation.
    * Fail: The service does not comply with the benchmark recommendation by default. Refer to the remediation section for an explanation and possible actions that you can take to comply with the benchmark recommendation.
* **Responsibility**
    * IBM: IBM is responsible for configuring the setting that the benchmark recommends.
    * Shared: You and IBM share responsibility for configuring the setting that the benchmark recommends.

### What parts of the benchmark am I responsible for?
{: #bencmark-resp}

Because {{site.data.keyword.containerlong_notm}} is a managed offering, IBM already configures many security settings for you. For example, IBM manages and automatically applies updates to your cluster master. For your worker nodes, IBM provides security and version updates, but you must apply the updates. You are also responsible for your workload applications and data. For more information, see [Your responsibilities while using {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-responsibilities_iks).

### What if some part of the service fails to comply with a recommendation?
{: #bencmark-service-compliance}

First, check the explanation of the failure for any remediation steps.

Then, determine whether the failure is acceptable according to your security requirements. For example, some recommendations might be more in-depth configuration requirements than your particular processes or standards require. Also, some recommendations are not scored, and don't impact the overall benchmark score.

Next, decide whether the component falls within your responsibility. If so, you might need to change how you configure that component. For example, you might configure pod security policies for all your app deployments. For components that are not directly within your responsibility, assess whether you can use another {{site.data.keyword.cloud_notm}} service to meet the recommendation.

### What else can I do to increase the security and compliance of my cluster?
{: #benchmark-what-else}

See [Security for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-security).

## Running the worker node CIS Kubernetes benchmark
{: #cis-worker-test}

To review the results of the CIS Kubernetes benchmark for Section 4: Worker node security configuration, you can run the test yourself. Because you own the worker nodes and are partially [responsible](/docs/containers?topic=containers-responsibilities_iks) for their compliance, you might make configuration changes that you want to validate on your own.
{: shortdesc}



Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Create a namespace for the resources to run the benchmark.
    ```sh
    kubectl create ns ibm-kube-bench-test
    ```
    {: pre}

2. Create a ConfigMap with the `config` and `node` configuration files from the [kube-samples](https://github.com/IBM-Cloud/kube-samples/tree/master/cis-kube-benchmark/cis-1.5/ibm){: external} GitHub repository.
    1. Download the `config` and `node` configuration files into a local directory called `ibm`. You can also clone the repository and navigate into the `ibm` directory.
        * [`config` file](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/cis-kube-benchmark/cis-1.5/ibm/config.yaml){: external}
        * [`node` file](https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/cis-kube-benchmark/cis-1.5/ibm/node.yaml){: external}
    2. Create the ConfigMap by using the `--from-file` option to specify the `ibm` directory where your downloaded the configuration files.
        ```sh
        kubectl create cm kube-bench-node -n ibm-kube-bench-test --from-file ibm
        ```
        {: pre}

3. Create a job to run the benchmark test based on the configurations that you previously created.
    ```sh
    kubectl apply -n ibm-kube-bench-test -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/cis-kube-benchmark/cis-1.5/ibm/job-node.yaml
    ```
    {: pre}

4. Check that the job completed.
    ```sh
    kubectl get pods -n ibm-kube-bench-test -l job-name=kube-bench-node
    ```
    {: pre}

    Example output

    ```sh
    NAME                    READY   STATUS      RESTARTS   AGE
    kube-bench-node-hlvhc   0/1     Completed   0          23s
    ```
    {: screen}

5. Review the CIS Kubernetes benchmark results for your worker nodes by checking the pod logs.
    ```sh
    kubectl logs -n ibm-kube-bench-test -l job-name=kube-bench-node --tail=-1
    ```
    {: pre}

    Example output

    ```sh
    == Summary ==
    20 checks PASS
    2 checks FAIL
    1 checks WARN
    0 checks INFO
    ```
    {: screen}

6. Optional: When you are done reviewing results, delete the resources that you created.
    ```sh
    kubectl delete ns ibm-kube-bench-test
    ```
    {: pre}
