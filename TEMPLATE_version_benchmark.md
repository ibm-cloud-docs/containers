# `Version benchmark` page template
Use this template to create a benchmark page when a new version is released.
Link to the benchmark results files: https://github.ibm.com/alchemy-containers/cis-kubernetes-benchmark-results

Link structure: https://cloud.ibm.com/docs/containers?topic=containers-cis-benchmark-1XX
File name: cs_benchmarks_1XX.md

Required changes and updates:
* Replace XX with the minor version number. 
* Copy and paste the benchmark tables into the each section. You do not need to copy the table headers. 
* Replace `IBM` in the `Responsibility` column with the `{{site.data.keyword.IBM_notm}}` conref. 
    * If you use find and replace, use `| IBM |` --> `| {{site.data.keyword.IBM_notm}} |`
* If the term `argument` is used to describe an option flag, replace it with `option` instead.
* Add tick marks around any option flags (e.g `--read-only-port`). 
    * Use this regex string: `(?!---)(?<!-)(--([\w-]*))`
    * Replace with ``$1``
* Search for any links to `#ibm-remediations-and-explanations` and replace them with `#cis-benchmark-remediations-1XX`. 
* Add `{: external}` tags to links.
    * Use this regex string: `(\(https:\/\/(?!cloud\.ibm)[\w.@?^=%&:\/)!~+#-]*\)(?!\{: external))`
    * Replace with `$1{: external}`

## IKS Template

---------------------------------------------------------------------------------------------------------------------------------------------------------

# Version 1.XX CIS Kubernetes Benchmark
{: #cis-benchmark-1XX}

The Center for Internet Security (CIS) publishes the [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes/){: external} as a framework of specific steps to configure Kubernetes more securely and with standards that are commensurate to various industry regulations. This document contains the results of the version 1.5 CIS Kubernetes benchmark for clusters that run Kubernetes version 1.XX. For more information or help understanding the benchmark, see [Using the benchmark](/docs/containers?topic=containers-cis-benchmark).
{: shortdesc}

## 1 Master Node Security Configuration
{: #cis-section-1-1XX}

Review the Master Node Security Configuration results of the version 1.5 CIS Kubernetes benchmark.
{: shortdesc}

### 1.1 Master Node Configuration Files
{: #cis-benchmark-11-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 1.1 Master node benchmark results" caption-side="top"}

### 1.2 API Server
{: #cis-benchmark-12-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 1.2 API Server benchmark results" caption-side="top"}

### 1.3 Controller Manager
{: #cis-benchmark-13-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 1.3 Controller Manager benchmark results" caption-side="top"}

### 1.4 Scheduler
{: #cis-benchmark-14-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 1.4 Scheduler benchmark results" caption-side="top"}

## 2 Etcd Node Configuration
{: #cis-section-2-1XX}

Review the Etcd Node Configuration results of the version 1.5 CIS Kubernetes benchmark.
{: shortdesc}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 2 Etcd Node Configuration benchmark results" caption-side="top"}

## 3 Control Plane Configuration
{: #cis-section-3-1XX}

Review the Control Plane Configuration results of the version 1.5 CIS Kubernetes benchmark.
{: shortdesc}

### 3.1 Authentication and Authorization
{: #cis-benchmark-31-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 3.1 Authentication and Authorization benchmark results" caption-side="top"}

### 3.2 Logging
{: #cis-benchmark-32-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 3.2 Logging benchmark results" caption-side="top"}

## 4 Worker Node Security Configuration
{: #cis-section-4-122}

Review the Worker Node Security Configuration results of the version 1.5 CIS Kubernetes benchmark.
{: shortdesc}

### 4.1 Worker Node Configuration Files
{: #cis-benchmark-41-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 4.1 Worker Node Configuration benchmark results" caption-side="top"}

### 4.2 Kubelet
{: #cis-benchmark-42-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 4.2 Kubelet benchmark results" caption-side="top"}

## 5 Kubernetes Policies
{: #cis-section-5-1XX}

Review the Kubernetes Policies results of the version 1.5 CIS Kubernetes benchmark.
{: shortdesc}

### 5.1 RBAC and Service Accounts
{: #cis-benchmark-51-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 5.1 RBAC and Service Accounts benchmark results" caption-side="top"}

### 5.2 Pod Security Policies
{: #cis-benchmark-52-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 5.2 Pod Security Policies benchmark results" caption-side="top"}

### 5.3 Network Policies and CNI
{: #cis-benchmark-53-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 5.3 Network Policies and CNI benchmark results" caption-side="top"}

### 5.4 Secrets Management
{: #cis-benchmark-54-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 5.4 Secrets Management benchmark results" caption-side="top"}

### 5.5 Extensible Admission Control
{: #cis-benchmark-55-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 5.5 Extensible Admission Control benchmark results" caption-side="top"}

### 5.6 General Policies
{: #cis-benchmark-56-1XX}

| Section | Recommendation | Scored? | Level | Result | Responsibility |
| --- | --- | --- | --- | --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column is the benchmark recommendation. The third column is the scoring of the recommendation, either scored or not scored. The fourth column is the level of the recommendation, either 1 for basic or 2 for more advanced and performance-impacting. The fifth column contains the result of whether the service passes or fails the recommendation. The sixth column designates the responsibility of passing the recommendation, either IBM or shared between IBM and you."}
{: caption="Section 5.6 General Policies benchmark results" caption-side="top"}

## IBM Remediations and Explanations
{: #cis-benchmark-remediations-1XX}

Review information from IBM on the CIS Benchmark results.
{: shortdesc}

| Section | Remediation/Explanation |
| --- | --- |

{: summary="The rows are read from left to right. The first column is the section number for the benchmark recommendation. The second column contains details on the remediation actions."}
{: caption="Explanation and remediation" caption-side="top"}

---------------------------------------------------------------------------------------------------------------------------------------------------------


