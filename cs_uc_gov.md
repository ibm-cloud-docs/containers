---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-22"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Government use cases for {{site.data.keyword.Bluemix_notm}}
{: #cs_uc_gov}

These use cases highlight how workloads on {{site.data.keyword.containerlong_notm}} can 
take advantage of isolation with Trusted Compute, toolchains for rapid app updates, data sharing with {{site.data.keyword.cloudant}}, global availability in multiple regions for data sovereignty, Watson machine learning instead of net-new code, and connections to existing on-prem databases.
{: shortdesc}

## Regional government improves collaboration and velocity with community developers who combine public-private data
{: #uc_data_mashup}

A Open-Gov Data Program Executive needs to share public data with the community and private sector, but the data's locked in an on-prem monolithic systems.

Why {{site.data.keyword.Bluemix_notm}}: With the {{site.data.keyword.containershort}}, the Exec delivers transformative value of combined public-private data. The service provides the public cloud platform to refactor and expose microservices from monolithic on-prem apps. Also the public cloud allows government and the public partnerships to leverage external Cloud services and collaboration-friendly open-source tools. 

Key technologies:    
* [Clusters that fit varied CPU, RAM, storage needs](cs_clusters_planning.html#shared_dedicated_node)
* [DevOps native tools, including open toolchains in {{site.data.keyword.contdelivery_full}}](https://www.ibm.com/cloud/garage/toolchains/)
* [Provide access to public data with {{site.data.keyword.cos_full_notm}}](https://console.bluemix.net/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage)
* [Plug-and-play Cloud Analytics services](https://www.ibm.com/cloud/analytics)

**Context: Government improves collaboration and velocity with community developers who combine public-private data**
* An “open government” model is clearly the future, but this regional government agency hasn’t been able to make the leap with their on-prem systems. 
* They want to support innovation and foster co-development between private sector, citizens, and public agencies.
* Disparate groups of developers from the government and private organizations don’t have a unified open-source platform where they can share APIs and data easily. 
* Government data is locked in on-prem systems with no easy public access. 

**The solution**

An open gov transformation must be built on a foundation that provides performance, resilience, business continuity, and security. As innovation and co-development proceed, agencies and citizens depend on software, services, and infrastructure companies to “protect and serve.” 

To bust bureaucracy and transform government’s relationship with its constituency, they turned to open standards to build a platform for co-creation:

* OPEN DATA – data storage where citizens, government agencies, and businesses can access, share, and enhance data freely
* OPEN APIs – a development platform where APIs are contributed by and reused with all community partners
* OPEN INNOVATION – a set of Cloud services that allow developers to plug in innovation instead of manually coding it

To start, the government uses {{site.data.keyword.cos_full_notm}} to store its public data in the cloud. This storage is free to use and reuse, shareable by anyone, and subject only to attribution and share alike. Sensitive data can be sanitized before it’s pushed to the cloud. Access controls are set up so that a limited area of new data can be stored in the cloud, where the community can demonstrate POCs of enhanced existing free data. 

The government’s next step for the public-private partnerships was to establish an API economy hosted in {{site.data.keyword.apiconnect_long}}. There, community and enterprise developers can make data easily accessible in API form. Their goals are to have publicly available REST APIs, to enable interoperability, and to accelerate app integration. They use IBM {{site.data.keyword.SecureGateway}} to connect back to private data sources on-prem. 

Finally, apps based on those shared APIs are hosted in the {{site.data.keyword.containershort}}, where it’s easy to spin up clusters. Then, developers across the community, private sector, and the government can co-create apps easily. In short, developers need to focus on coding instead of managing the infrastructure. Thus, they chose the {{site.data.keyword.containershort}} because IBM simplifies infrastructure management:
* Managing Kubernetes master, IaaS, and operational components, such as Ingress and storage
* Monitoring health and recovery for worker nodes
* Providing global compute, so developers don’t have to stand up infrastructure in geographies where they need workloads and data to reside

Moving compute workloads into the {{site.data.keyword.Bluemix_notm}} isn't enough though. The government needs to go through a process and methods transformation as well. By adopting the best practices of the IBM Garage Method, the provider can implement an agile and iterative delivery process that supports modern DevOps practices like Continuous Integration and Delivery (CI/CD).

Much of the CI/CD process itself is automated with {{site.data.keyword.contdelivery_full}} in the Cloud. The provider can define workflow toolchains to prepare container images, check for vulnerabilities, and deploy them to the Kubernetes cluster.

**Solution model**

On-demand compute, storage, and API tools run in the public cloud with secure access to and from on-prem data sources. 

Technical solution:
* {{site.data.keyword.containerlong_notm}}
* {{site.data.keyword.cos_full_notm}} and {{site.data.keyword.cloudant}}
* {{site.data.keyword.apiconnect_long}}
* IBM {{site.data.keyword.SecureGateway}}
* {{site.data.keyword.contdelivery_full}}

**Step 1: Store data in the cloud**
* {{site.data.keyword.cos_full_notm}} provides historical data storage, accessible to all on the public cloud.
* Use {{site.data.keyword.cloudant}} with developer-provided keys to cache data in the cloud.
* Use IBM {{site.data.keyword.SecureGateway}} to maintain secure connections to existing on-prem databases.

**Step 2: Provide access to data via APIs**
* Use {{site.data.keyword.apiconnect_long}} for the API economy platform. APIs allow the public and private sectors to combine data into their apps.
* Create clusters for public-private apps, which are driven by the APIs. 
* Architect apps into a set of cooperative microservices that run within the {{site.data.keyword.containershort}}, which is based on functional areas of apps and their dependencies.
* Deploy the apps to containers that run in {{site.data.keyword.containerlong_notm}}. Built-in HA tools in the {{site.data.keyword.containershort}} balance the workloads, including self-healing and load balancing.
* Provide standardized DevOps dashboards through Kubernetes, open-source tools familiar to all types of developers.

**Step 3: Innovate with IBM Garage and Cloud services**
* Adopt the essential agile and iterative development practices within the IBM Garage Method to enable frequent releases of new functions, patches, and fixes without downtime. 
* Irrespective of whether the developers are in the public or private sector, {{site.data.keyword.contdelivery_full}} helps them to quickly provision an integrated toolchain, by using customizable, shareable templates with tools from IBM, third parties, and open source. 
* After developers build and test the apps in their Dev and Test clusters, they use the {{site.data.keyword.contdelivery_full}} toolchains to deploy apps into production clusters.
* With Watson AI, machine learning, and deep learning tools available from the {{site.data.keyword.Bluemix_notm}} catalog, developers focus on domain problems. Instead of custom unique ML code, ML logic is snapped into apps via service bindings.

**Results**
* Normally slow public-private partnerships now quickly spin up apps in weeks instead of months. These development partnerships now deliver features and bug fixes up to 10x per week. 
* Development is accelerated when all participants leverage well-known open-source tools, such as Kubernetes. Long learning curves are no longer a blocker. 
* Transparency in activities, information, and plans is provided to citizens and private sector. And, citizens are integrated into government processes, services, and support.
* Public-private partnerships conquer Herculean tasks, such as Zika virus tracking, smart electricity distribution, crime statistic analysis, and university ‘new collar’ education.

## Large public port secures the exchange of port data and shipping manifests that connect public and private organizations
{: #uc_port}

IT Execs for a private shipping company and the government-operated port need to connect, provide visibility, and securely exchange port information. But no unified system existed to connect public port information and private shipping manifests.

Why {{site.data.keyword.Bluemix_notm}}: The {{site.data.keyword.containershort}} allows government and the public partnerships to leverage external Cloud services and collaboration-friendly open-source tools. The containers provided a shareable platform where both the port and shipping company could feel assured that the shared information was hosted on a secure platform, which could scale as they went from small Dev-Test systems to ultimately production-sized systems. Open toolchains further accelerated development by automating build, test, and deployments. 

Key technologies:    
* [Clusters that fit varied CPU, RAM, storage needs](cs_clusters_planning.html#shared_dedicated_node)
* [Container security and isolation](cs_secure.html#security)
* [DevOps native tools, including open toolchains in {{site.data.keyword.contdelivery_full}}](https://www.ibm.com/cloud/garage/toolchains/)
* [SDK for Node.js](https://console.bluemix.net/docs/runtimes/nodejs/index.html#nodejs_runtime)

**Context: Port secures exchange of port data and shipping manifests that connects public and private organizations.**

* Disparate groups of developers from the government and shipping company don’t have a unified platform where they can collaborate, which slows down deployments of updates and features. 
* Developers are spread across the globe and across organizational boundaries, which means open-source and PaaS the best option.
* Security is a primary concern, and this concern only adds to the collaboration burden that impacts features and updates to the software, especially once the apps are in production.
* Just-in-time data meant the world-wide systems must be highly available to reduce lags in transit operations. Time tables for ship terminals are highly controlled and in some cases inflexible. Web usage will be high, so instability could cause poor user experience. 

**The solution**

The port and the shipping company co-develop a unified trading system to electronically submit compliance-related information required for the clearance of goods and craft once, rather than to multiple agencies. Manifest and customs apps can quickly share contents of a particular shipment and ensure that all paperwork is electronically transferred and processed by agencies for the port. 

So they create a partnership dedicated to solutions for the trade system:
* DECLARATIONS - App to intake shipping manifests and digitally process typical customs paperwork; ability to flag out-of-policy items for investigation and enforcement
* TARIFFS – App to calculate tariffs, submit charges electronically to shipper, and receive digital payments
* REGULATIONS – Flexible and configurable app that feeds previous two apps with ever-changing policies and regulations that affect imports, exports, and tariff processing

Developers started by deploying their apps in containers with the {{site.data.keyword.containershort}}. They created clusters for a shared Dev environment that allow world-wide developers to collaboratively deploy app improvements quickly. Containers allow each development team to use the language of their choice.

Security first: The IT Execs chose Trusted Compute for bare metal to host the clusters. With bare metal for the {{site.data.keyword.containershort}}, the sensitive customs workloads now have familiar isolation but within the flexibility of public cloud. Bare metal provides Trusted Compute, which can verify the underlying hardware against tampering. 

Because the shipping company wants to also partner with other ports, app security is crucial. Shipping manifests and customs information are highly confidential. From that secure core, Vulnerability Advisor provides image vulnerability scans, policy scans that are based on ISO 27k, live container scans, and package scans for known malware. While at the same time, {{site.data.keyword.iamlong}} provides the ability to control who has which level of access to the resources.

Developers focus on domain problems, by leveraging existing tools: Instead of developers writing unique logging and monitoring code, they snap it into apps, by binding {{site.data.keyword.Bluemix_notm}} services to clusters. Developers are also freed up from infrastructure management tasks because IBM takes care of Kubernetes and infrastructure upgrades, security, and more. 

**Solution model**

On-demand compute, storage, and Node starter kits that run in the public cloud with secure access to shipping data across the globe, as needed. Compute in clusters is tamper-proof and isolated to bare metal.  

Technical solution:
* {{site.data.keyword.containerlong_notm}} with Trusted Compute
* {{site.data.keyword.openwhisk}}
* {{site.data.keyword.cloudant}}
* IBM {{site.data.keyword.SecureGateway}}

**Step 1: Containerize apps, by using microservices**
* Leverage the Node.js starter kit from IBM to jump start development.
* Architect apps into a set of cooperative microservices that run within the {{site.data.keyword.containershort}} based on functional areas of the app and its dependencies.
* Deploy the manifest and shipment apps to container that run in the {{site.data.keyword.containershort}}. 
* Provide standardized DevOps dashboards through Kubernetes.
* Use IBM {{site.data.keyword.SecureGateway}} to maintain secure connections to existing on-prem databases.

**Step 2: Ensure global availability**
* After developers for the shipping company build and test the apps in their Dev and Test clusters, they use the {{site.data.keyword.contdelivery_full}} toolchains and Helm deployment tools to deploy similar apps into clusters for other countries across the globe. 
* Workloads and data can then meet regional regulations. 
* Built-in HA tools in the {{site.data.keyword.containershort}} balance the workload within each geographic region, including self-healing and load balancing.

**Step 3: Data sharing**
* {{site.data.keyword.cloudant}} is a modern NoSQL database suitable a range of data-driven use cases from key-value to complex document-oriented data storage and query. 
* To minimize queries to the regional databases, {{site.data.keyword.cloudant}} is used to cache the user's session data across apps. 
* This configuration improves the front-end app usability and performance across all apps hosted on the {{site.data.keyword.containershort}}.
* While worker apps in the {{site.data.keyword.containershort}} analyze on-prem data and store results in {{site.data.keyword.cloudant}}, {{site.data.keyword.openwhisk}} reacts to changes and automatically sanitizes data on on the incoming feeds of data. 
* Similarly, notifications of shipments in one region can be triggered through data uploads, so that all down-stream consumers can leverage new data.

**Results**
* With IBM starter kits, the {{site.data.keyword.containershort}}, and {{site.data.keyword.contdelivery_full}} tools, global developers partner across organizations and governments and collaboratively develop customs apps, with familiar and interoperable tools. 
* Microservices greatly reduce time to delivery for patches, bug fixes, and new features. Initial development is fast, and updates are frequently 10x per week.
* Shipping customers and government officials have access to manifest data and can share customs data, while they comply with local regulations. 
* The shipping company benefits from improved logistics management in the supply chain: reduced costs and faster clearance times.
* 99% are digital declarations, and 90% of imports processed without human intervention.

