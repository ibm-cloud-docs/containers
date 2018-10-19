---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-19"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Healthcare use cases for IBM Cloud
{: #cs_uc_health}

These use cases highlight how workloads on {{site.data.keyword.containerlong_notm}} can 
take advantage of secure compute on isolated bare metal, easy spin-up of clusters for faster development, migration from virtual machines, and data sharing in cloud databases. 
{: shortdesc}

## Healthcare provider migrates workloads from inefficient VMs to Ops-friendly containers for reporting & patient systems
{: #uc_migrate}

An IT Exec for a healthcare provider has business reporting and patient systems on-prem. Those systems go through slow enhancement cycles, which leads to stagnant patient service levels.

Why IBM Cloud: To improve patient service, the provider looked to IBM Cloud Kubernetes Service and IBM Continuous Delivery to reduce IT spend and accelerate development, all on a secure platform. The provider’s high-use SaaS systems, which held both patient record systems and business reporting apps, needed updates frequently, but the on-prem environment hindered agile development. The provider also wanted to counteract increasing labor costs and a decreasing budget. 

Key technologies:    
* Design clusters to fit CPU, RAM, storage needs
* Horizontal scaling
* Container security & isolation
* DevOps native tools, including open toolchains in IBM Cloud Continuous Delivery
* SDK for Node.js

They started by containerizing their SaaS systems and putting them in the cloud. They went from over-built hardware in a private data center to customizable compute that reduces IT operations, maintenance, and energy. To host the SaaS systems, they could easily design Kubernetes clusters to fit their CPU, RAM, and storage needs. Another factor for lower manpower costs is that IBM manages Kubernetes, so the provider can focus on delivering better customer service.

Accelerated development is a key win for the IT Exec. With the move to public cloud, Developers can experiment easily with Node.js SDK, pushing changes to Dev and Test systems, scaled out on separate clusters. Those pushes were automated with open toolchains and IBM Continuous Delivery. No longer were updates to the SaaS system languishing in slow, error-prone build processes. They can deliver incremental updates to their users, daily or even more frequently.  Moreover logging and monitoring for the SaaS systems, especially how the patient front-end and back-end reports interact, comes out of the box. Developers don’t waste time building complex logging systems, just to be able to troubleshoot live systems. 

Security first: With bare metal for {{site.data.keyword.containerlong_notm}}, the sensitive patient workloads now have familiar isolation but within the flexibility of public cloud. Bare metal provides Trusted Compute, which can verify the underlying hardware against tampering. From that core, Vulnerability Advisor provides image vulnerability scanning, policy scanning based on ISO 27k, live container scanning, and package scanning for known malware. Secure patient data leads to happier patients.

**Context: Workload migration for the Healthcare Provider**

* Technical debt coupled with long release cycles is hindering the provider’s business critical patient management & reporting systems.
* Their back office and front office custom apps are delivered on-prem in monolithic virtual machine images.
* They need to overhaul their processes, methods, and tools but don’t know quite where to start.
* Their technical debt is growing, not shrinking from an inability to release quality software to keep up with market demands
* Security has become a primary concern, and this is only adding to the delivery burden causing even more delays.
* Capital expense budgets are under tight control, and IT feels they don't have the budget or manpower to created the needed testing and staging landscapes with their in-house systems.

**Solution model**

On-demand compute, storage, and IO services running in public cloud with secure access to on-prem enterprise assets as warranted. Implement a CI/CD process and other parts of the IBM Garage method to dramatically shorten delivery cycles.

**Step 1: Secure the compute platform**
* Apps that are deemed as managing highly sensitive patient data can be rehosted on {{site.data.keyword.containerlong_notm}} running on Bare Metal for Trusted Compute.
* Trusted Compute can verify the underlying hardware against tampering. 
* From that core, Vulnerability Advisor provides image, policy, container, and packaging scanning vulnerability scanning, for known malware. 

**Step 2: Lift & shift**
* Migrate virtual machine images to container images running in IBM Cloud Kubernetes Service in the public IBM Cloud.
* Provide standardized DevOps dashboards and practices through Kubernetes.
* Enable on-demand scaling of compute for batch and other back office workloads that run infrequently.
* Use IBM Secure Gateway to maintain secure connections to on-prem DBMS.
* Private data center / on-prem capital costs are greatly reduced and replaced with a utility computing model that scales based on workload demand.

**Step 3: Microservices & Garage method**
* Rearchitect apps into a set of cooperative microservices running within {{site.data.keyword.containerlong_notm}} based on functional areas of the app with the most quality problems.
* Use Cloudant with customer provided keys for caching data in the cloud.
* Adopt CI/CD best practices to support versioning & releasing a microservice on its own schedule as needed. IBM Continuous Delivery provides for workflow toolchains for CI/CD process along with image creation and vulnerability scanning of container images. 
* Adopt the essential agile and iterative development practices within the IBM Garage method to enable frequent releases of new functions, patches, and fixes without downtime.

**Technical solution**
* IBM Cloud Kubernetes Service
* IBM Cloudant
* IBM Secure Gateway

For the most sensitive workloads, the clusters can be hosted in {{site.data.keyword.containerlong_notm}} for Bare Metal, provided a trusted compute platform that automatically scans hardware and runtime code for vulnerabilities. Using industry-standard containers technology, apps can initially be rehosted on {{site.data.keyword.containerlong_notm}} quickly without major architectural changes. This provides the immediate benefit of scalability. 

They will also be able to replicate and scale the apps using defined rules and the automated Kubernetes orchestrator. {{site.data.keyword.containerlong_notm}} provides scalable compute resources and the associated DevOps dashboards to create, scale, and tear down apps and services on demand. Using Kubernetes rich set of deployment & runtime objects, the provider will be able to monitor & manage upgrades to apps reliably.

IBM Secure Gateway is used to create a secure pipeline to on-prem databases and documents for apps rehosted to run in {{site.data.keyword.containerlong_notm}}.

IBM Cloudant is a modern NoSQL database suitable a range of data driven use cases from key-value to complex document oriented data storage and query. To minimize queries to the back office RDBMS Cloudant is used to cache the user's session data across apps. This improves the front end app usability and performance across all apps hosted on {{site.data.keyword.containerlong_notm}}.

Moving compute workloads into the IBM Cloud isn't enough though. The provider needs to go through a process and methods transformation as well. By adopting the best practices of the IBM Garage Method, the provider can implement an agile and iterative delivery process that supports modern DevOps practices like Continuous Integration & Delivery (CI/CD).

Much of the CI/CD process itself is automated with IBM's Continuous Delivery service in the Cloud. The provider can define workflow toolchains to prepare container images, check for vulnerabilities, and deploy them to the Kubernetes cluster. 

**Results**
* Lifting the existing monolithic VMs into cloud-hosted containers was a first step that allowed the provider to save on capital costs and begin learning modern DevOps best practices.
* Rearchitecting monolithic apps to a set of course grained microservices greatly reduced time to delivery for patches, bug fixes, and new features. 
* In parallel, the provider implemented simple time-boxed iterations to get a handle on the existing technical debt.

## Research nonprofit securely hosts sensitive data while growing research with partners
{: #uc_research}

A Development Exec for a disease research nonprofit has academic and industry researchers who can't easily share research data. Their work is instead isolated in pockets across the globe due to regional compliance regulations and centralized databases.

Why IBM Cloud: IBM Cloud Kubernetes Service delivers secure compute that can host sensitive and performant data processing on an open platform. That global platform is hosted in near-by geographies and tied to local regulations, inspiring patients’ and researchers’ confidence that their data is both protected locally and making a difference in better health outcomes.

Key technologies:    
* Intelligent scheduling places workloads where needed    
* Cloudant to persist and sync data across apps
* Vulnerability scanning  and isolation for workloads    
* DevOps native tools, including open toolchains in IBM Cloud Continuous Delivery
* IBM Cloud Functions to sanitize data and notify researchers about data structure changes

**Context: Securely hosting and sharing disease data for Research Nonprofit**

* Disparate groups of researchers from various institutions don’t have a unified way to share data, slowing down collaboration. 
* Security is a primary concern, and this is only adding to the collaboration burden causing even less shared research. 
* Developers and Researchers are spread across the globe and across organizational boundaries, making PaaS and SaaS the best option for each user group. 
* Regional differences in health regulations require some data and data processing to remain within that region. 

**The solution**
The research nonprofit wants to aggregate cancer research data across the globe. So they create a division dedicated to solutions for the end-user researchers:
* INGEST - Apps to ingest research data. Researchers today use spreadsheets, documents, commercial products, and proprietary/home grown databases to record research results. This likely won't change with the nonprofit's attempt to centralize data analysis.
* ANONYMIZE - Apps to anonymize the data. All SPI has to be removed in order to comply with regional health regulations. 
* ANALYZE - Apps to analyze the data. The basic pattern is to store the data in a regular format and then to be able to query/process it using AI/ML technology, simple regressions, etc.

Researchers will affiliate with a regional cluster, and apps ingest, transform, and anonymize data:
1. Syncing the anonymized data across regional clusters or shipping them to a centralized data store
2. Processing the data, by using machine learning (ML) like PyTorch on bare metal worker nodes that provide GPUs 

**INGEST** IBM Cloudant is used at each regional cluster, storing researchers’ rich data documents that can be queried and processed as needed. Cloudant encrypts data at rest and in transit as a best practice -- complying with regional data privacy laws.

IBM Cloud Functions is used to create processing functions for ingesting research data storing them as structured data documents in Cloudant. IBM Secure Gateway provides an easy way for Functions to access on-prem data in a safe and secure manner.

Web apps in the regional clusters are developed in nodeJS for manual data entry of results, schema definition, research organizations affiliation, etc. IBM Key Protect is used to secure all access to Cloudant data, and IBM Vulnerability Advisor scans app containers and images for security exploits.

**ANONYMIZE** Anytime a new data document is stored in Cloudant and event is triggered and a Cloud Function is executed to anonymize the data and remove all SPI from the data document. These anonymized data documents are stored separate from the "raw" data ingested and are the only documents shared across regions for analysis.

**ANALYZE** Machine learning frameworks are very compute intensive, and thus the nonprofit has set up a global processing cluster of bare metal worker nodes. Associated with this global processing cluster is an aggregated Cloudant database of all the anonymized data. A cron job periodically triggers a Cloud Function to push anonymized data documents from the regional centers to the global processing cluster's Cloudant instance.

The compute cluster runs the PyTorch ML framework and machine learning apps are written in Python to analyze the aggregated data. In addition to ML apps, researchers in the collective group also develop their own apps that can be published and run on the global cluster.

The nonprofit also provides apps that run on non-baremetal nodes of the global cluster to view and extract the aggregated data and the various ML app outputs. These view/export apps are accessible via a public endpoint secured by API Gateway to the world, so researchers and data analysts from everywhere can download data sets and do their own analysis.

**Hosting research workloads on {{site.data.keyword.containerlong_notm}}**

Developers started by deploying their research-sharing SaaS apps in containers with IBM Cloud Kubernetes Service. They created clusters for a Dev environment that allow world-wide Developers to collaboratively deploy app improvements quickly.

Security first: The Development Exec chose Trusted Compute for bare metal to host the research clusters. With bare metal for {{site.data.keyword.containerlong_notm}}, the sensitive research workloads now have familiar isolation but within the flexibility of public cloud. Bare metal provides Trusted Compute, which can verify the underlying hardware against tampering. Because this nonprofit also partners with pharmaceutical companies, app security is crucial. Competition is fierce, and corporate espionage is possible. From that secure core, Vulnerability Advisor provides image vulnerability scanning, policy scanning based on ISO 27k, live container scanning, and package scanning for known malware. Secured research apps lead to increased clinical trial participation.

To achieve global availability, the Dev, Test, and Production systems were deployed across the globe in several data centers. For HA, they use a combination of multiple clusters in multiple geographic regions as well as multizone clusters. They can easily deploy the research app to Frankfort clusters to comply with the local European regulation and also deploy the app within the United States clusters to ensure availability and failure recovery locally. They also spread the research workload across multizone clusters in Frankfort to ensure that the European app is available and also balances the workload efficiently. Because researchers are uploading sensitive data with the research-sharing app, the app’s clusters are hosted in regions where stricter regulations apply.

Developers focus on domain problems, by leveraging existing tools: Instead of writing unique ML code, ML logic is snapped into apps, by binding IBM Cloud services to clusters. Developers are also freed up from infrastructure management tasks because IBM takes care of Kubernetes and infrastructure upgrades, security, and more. 

**Solution model**

On-demand compute, storage, and Node starter kits running in public cloud with secure access to research data across the globe, as warranted. Compute in clusters is tamper-proof and isolated to bare metal.

Technical solution:
* IBM Cloud Kubernetes Service with Trusted Compute
* IBM Cloud Functions
* IBM Cloudant
* IBM Secure Gateway

**Step 1: Containerize apps using microservices**
* Leverage the Node.js starter kit from IBM to jump start development.
* Architect apps into a set of cooperative microservices running within {{site.data.keyword.containerlong_notm}} based on functional areas of the app and its dependencies.
* Deploy research apps to containers running in IBM Cloud Kubernetes Service. 
* Provide standardized DevOps dashboards through Kubernetes.
* Enable on-demand scaling of compute for batch and other research workloads that run infrequently.
* Use IBM Secure Gateway to maintain secure connections to existing on-prem databases.

**Step 2: Leverage secure and performant compute**
* ML apps that require higher performing compute are hosted on {{site.data.keyword.containerlong_notm}} running on Bare Metal. This ML cluster is centralized, so each regional cluster doesn't have the expense of bare metal workers; Kubernetes deployments are easier too. 
* Apps that process highly sensitive clinical data can be hosted on {{site.data.keyword.containerlong_notm}} running on Bare Metal for Trusted Compute.
* Trusted Compute can verify the underlying hardware against tampering. From that core, Vulnerability Advisor provides image, policy, container, and packaging scanning vulnerability scanning, for known malware. 

**Step 3: Ensure global availability**
* After Developers build and test the apps in their Dev and Test clusters, they use the IBM CI/CD toolchains to deploy apps into clusters across the globe. 
* Built-in HA tools in {{site.data.keyword.containerlong_notm}} balance the workload within each geographic region, including self-healing and load balancing.
* Using the toolchains and Helm deployment tools, the apps are also deployed to clusters across the globe, so workloads and data meet regional regulations. 

**Step 4: Data sharing**
* IBM Cloudant is a modern NoSQL database suitable a range of data driven use cases from key-value to complex document oriented data storage and query. 
* To minimize queries to the regional databases, Cloudant is used to cache the user's session data across apps. 
* This improves the front-end app usability and performance across all apps hosted on {{site.data.keyword.containerlong_notm}}.
* While worker apps running in {{site.data.keyword.containerlong_notm}} analyze on-prem data and store results in Cloudant, IBM Cloud Functions reacts to changes and automatically sanitizes data on on the incoming feeds of data. 
* Similarly, notifications of research breakthroughs in one region can be triggered through data uploads, so that all researchers can leverage new data.

**Results**
* With starter kits, {{site.data.keyword.containerlong_notm}}, and IBM CI/CD tools, global Developers partner across institutions and collaboratively develop research apps, with familiar and interoperable tools. 
* Microservices greatly reduce time to delivery for patches, bug fixes, and new features. Initial development is fast, and updates are frequent.
* Researchers have access to clinical data and can share clinical data, while complying with local regulations.
* Patients who participate in disease research feel confident that their data is secure and making a difference, when shared with large research teams. 

