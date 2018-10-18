---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Financial services use cases for IBM Cloud
{: #cs_uc_finance}

These use cases highlight how workloads on {{site.data.keyword.containerlong_notm}} can 
take advantage of high availability, high-performance
compute, easy spin-up of clusters for faster development, and AI from IBM Watson. 
{: shortdesc}

## Mortgage company trims costs and accelerates regulatory compliance
{: #uc_mortgage}

A Risk Management VP for a residential mortgage company processes 70 million records a day, but the on-prem system was slow and also inaccurate. IT expenses soared because hardware quickly went out of date and wasn't utilized fully. While they waited for hardware provisioning, their regulatory compliance slowed. 

Why IBM Cloud: To improve risk analysis, the company looked to IBM Cloud Kubernetes Service and IBM Cloud Analytic services to reduce costs, increase worldwide availability, and ultimately accelerate regulatory compliance. With {{site.data.keyword.containerlong_notm}} in multiple regions, their analysis apps can be containerized and deployed across the globe, improving availability and addressing local regulations. Those deployments are accelerated with familiar open source tools, already part of {{site.data.keyword.containerlong_notm}} ecosystem.

{{site.data.keyword.containerlong_notm}} and key technologies:    
* Horizontal scaling
* Multi-regions for high availability
* Design clusters to fit CPU, RAM, storage needs
* Container security & isolation
* IBM Cloudant to persist and sync data across apps
* SDK for Node.js

**The solution**

They started by containerizing the analysis apps and putting them in the cloud. In a flash, their hardware headaches went away. They could easily design Kubernetes clusters to fit their high-performance CPU, RAM, storage, and security needs. And when their analysis apps change, they can add or shrink compute without huge hardware investments. With {{site.data.keyword.containerlong_notm}} horizontal scaling, their apps scale with the growing number of records, resulting in faster regulatory reports. {{site.data.keyword.containerlong_notm}} provides elastic compute resources around the world that are secure and highly performant for full utilization of modern compute resources.

Now those apps receive high-volume data from a data warehouse on Cloudant. Cloud-based storage in Cloudant ensures higher availability than when it was frozen in an on-prem system. Since availability is essential, the apps are deployed across global data centers: for DR and for latency too.

They also accelerated their risk analysis and compliance. Their predictive and risk analytics functions, such as Monte Carlo calculations, are now constantly updated via iterative Agile deployments. Container orchestration is handled by a managed Kubernetes, so that operations costs are reduced too. Ultimately risk analysis for mortgages is more responsive to the fast-paced changes in the market.   

**Context: Compliance & financial modeling for residential mortgages**

* Heightened need for better financial risk management is driving the increase in regulatory oversight and associated review in risk assessment processes and disclosure of more granular, integrated, and abundant regulatory reporting.
* High Performance Computing Grids are the key infrastructure components for financial modeling.

The company’s problem right now is scale and time to delivery. 

Their current environment is 7+ years old, on-prem, and with limited compute, storage, and IO capacity.
Server refreshes are costly and take a long time to complete. 
Software and app updates follow an ad-hoc process and are not repeatable. 
The actual HPC grid is hard to program against, the API is too complex for new developers brought on board and requires a lot of non-documented knowledge. 
Right now major app upgrades take 6-9 months to execute. 

**Solution model: On-demand compute, storage, and IO services running in public cloud with secure access to on-prem enterprise assets as warranted**

* Secure & scalable document storage supporting structured and unstructured document query
* "Lift and shift" existing enterprise assets and app while enabling the integration to some on-prem systems that won't be migrated
* Shorten time-to-deploy solutions and implement standard DevOps and monitoring processes to address bugs that affected reporting accuracy

**Detailed solution**

* IBM Kubernetes Container Service
* IBM Cloud Object Storage
* IBM Cloud SQL Query (Spark)
* IBM Cloudant
* IBM Secure Gateway

{{site.data.keyword.containerlong_notm}} provides scalable compute resources and the associated devops dashboards to create, scale, and tear down apps and services on demand. Using industry-standard containers, apps can initially be rehosted on {{site.data.keyword.containerlong_notm}} quickly without major architectural changes. 

This provides the immediate benefit of scalability. Using Kubernetes rich set of deployment & runtime objects, the mortgage company will be able to monitor & manage upgrades to apps reliably. They will also be able to replicate and scale the apps using defined rules and the automated Kubernetes orchestrator.

Secure Gateway is used to create a secure pipeline to on-prem databases and documents for apps rehosted to run in {{site.data.keyword.containerlong_notm}}.

Cloud Object Storage is for all raw document and data storage going forward. For Monte Carlo simulations, a workflow pipeline is put in place where simulation data is in structured input files stored in COS. A trigger to initiate the simulation scales compute services in {{site.data.keyword.containerlong_notm}} to split the input data into N event buckets for simulation processing. {{site.data.keyword.containerlong_notm}} automatically scales to N associated service executions and writes intermediate results to COS which are processed by another set of {{site.data.keyword.containerlong_notm}} compute services to produce the final results.

Cloudant is a modern NoSQL database suitable for a range of data driven use cases from key-value to complex document oriented data storage and query. To manage the growing set of regulatory & management reporting rules, the mortgage company uses Cloudant to store documents associated with all raw regulatory data input coming into the firm. Compute processes on {{site.data.keyword.containerlong_notm}} are triggered to aggregate, process, and publish the data in the various reporting formats needed. Intermediate results common across reports are stored as Cloudant documents so template driven processes can be used to produce the necessary reports.

**Results**

* Complex financial simulations are completed in 25% of the time than was previously possible with the legacy on-prem systems.
* Time to deployment improved from the previous 6-9 months to 1-3 weeks on average. This is because {{site.data.keyword.containerlong_notm}} allows for a disciplined, controlled process for ramping up app containers and replacing them with newer versions. Reporting bugs can be fixed quickly, addressing issues, such as accuracy. 
* Regulatory reporting costs were reduced with a consistent, scalable set of storage and compute services that {{site.data.keyword.containerlong_notm}} and Cloudant bring.
* Over time legacy apps that were initially "lifted and shifted" to the cloud were re-architected into a set of cooperating microservices running on {{site.data.keyword.containerlong_notm}}. This further sped up development and time to deploy and allowed more innovation because of the relative ease of experimenting and releasing newer versions of microservices to take advantage of market and business conditions (i.e. so called situational apps and microservices).

## Payment tech company streamlines developer productivity, deploying AI-enabled tools to their partners 4x faster
{: #uc_payment_tech}

A Development Exec has developers using on-prem traditional tools slowing down prototyping while they wait for hardware procurement.

Why IBM Cloud: IBM Cloud Kubernetes Service provides spin-up of compute using open-source standard technology. After moving to {{site.data.keyword.containerlong_notm}}, developers have access to DevOps-friendly tools, such as portable and easily-shared containers.

Then, developers can experiment easily, pushing changes to Dev and Test systems quickly with open toolchains. Their traditional software development tools get a new face when they add on AI cloud services to apps with a click. 

Key technologies:    
* Design clusters to fit CPU, RAM, storage needs
* Fraud prevention with Watson AI 
* DevOps native tools, including open toolchains in IBM Cloud Continuous Delivery
* SDK for Node.js

**Context: Streamlining developer productivity and deploying AI tools to partners 4x faster**

* Disruption is rampant in the payment industry that also has dramatic growth both in the consumer and business-to-business segments. But updates to payment tools were slow.  
* Cognitive features are needed to target fraudulent transactions in new and faster ways.
* Due to growing numbers of partners and their transactions, the tool traffic will increase, but their infrastructure budget actually needs to decrease, by maximizing efficiency of the resources.
* Their technical debt is growing, not shrinking from an inability to release quality software to keep up with market demands.
* Capital expense budgets are under tight control, and IT feels they don't have the budget or manpower to created the needed testing and staging landscapes with their in-house systems.
* Security has become a primary concern, and this is only adding to the delivery burden causing even more delays.

**The solution**

The Development Exec is faced with many challenges in the dynamic payment industry. Regulations, consumer behaviors, fraud, competitors, and Market Infrastructures are all rapidly evolving. Fast-paced development is essential to being part of the future payment world.

Their business model is to provide payment tools to business partners, so they can help these financial institutions and other organizations deliver security-rich digital payment experiences. 

They need a solution that could help the developers and their business partners: 
* FRONT-END TO PAYMENT TOOLS: fee systems, payment tracking including cross-border, regulatory compliance, biometrics, remittance, and more
* REGULATION-SPECIFIC FEATURES: each country has unique regulations, so that the overall toolset might look similar but show country-specific benefits
* DEVELOPER-FRIENDLY TOOLS that accelerate roll-out of features and bug fixes 
* FRAUD DETECTION AS A SERVICE (FDaaS) leverages Watson AI to keep one step ahead of frequent and growing fraudulent actions

**Solution model**

On-demand compute, DevOps tools, and AI running in public cloud with access to back-end payment systems. Implement a CI/CD process to dramatically shorten delivery cycles.

Technical solution:
* IBM Cloud Kubernetes Service
* IBM Cloud Continuous Delivery
* IBM Cloud Logging and Monitoring
* IBM Watson for Financial Services

They started by containerizing the payment tool VMs and putting them in the cloud. In a flash, their hardware headaches went away. They could easily design Kubernetes clusters to fit their CPU, RAM, storage, and security needs. And when their payment tools need to change, they can add or shrink compute without expensive and slow hardware purchases. 

With {{site.data.keyword.containerlong_notm}} horizontal scaling, their apps scale with the growing number of partners, resulting in faster growth. {{site.data.keyword.containerlong_notm}} provides elastic compute resources around the world that are secure for full utilization of modern compute resources. 

Accelerated development is a key win for the HR Exec. With the use of modern containers, developers can experiment easily in the languages of their choice, pushing changes to Dev and Test systems, scaled out on separate clusters. Those pushes were automated with open toolchains and IBM Cloud Continuous Delivery. No longer were updates to the tools languishing in slow, error-prone build processes. They can deliver incremental updates to their tools, daily or even more frequently. 

Moreover logging and monitoring for the tools, especially where they leveraged Watson AI, come out of the box. Developers don’t waste time building complex logging systems, just to be able to troubleshoot their live systems. A key factor for lower manpower costs is that IBM manages Kubernetes, so the developers can focus on better payment tooling.

Security first: With bare metal for {{site.data.keyword.containerlong_notm}}, the sensitive payment tools now have familiar isolation but within the flexibility of public cloud. Bare metal provides Trusted Compute, which can verify the underlying hardware against tampering. Scanning for vulnerabilities and malware are run continuously.  

**Step 1: Lift & shift to secure compute**
* Apps that are deemed as managing highly sensitive data can be rehosted on {{site.data.keyword.containerlong_notm}} running on Bare Metal for Trusted Compute. Trusted Compute can verify the underlying hardware against tampering. 
* Migrate virtual machine images to container images running in IBM Cloud Kubernetes Service in the public IBM Cloud.
* From that core, Vulnerability Advisor provides image, policy, container, and packaging scanning vulnerability scanning, for known malware. 
* Private data center / on-prem capital costs are greatly reduced and replaced with a utility computing model that scales based on workload demand.

**Step 2: Operations and connections to existing payment systems back-end**
* Use IBM Secure Gateway to maintain secure connections to on-prem tool systems.
* Provide standardized DevOps dashboards and practices through Kubernetes.
* After developers build and test the apps in their Dev and Test clusters, they use the IBM CI/CD toolchains to deploy apps into {{site.data.keyword.containerlong_notm}} clusters across the globe. 
* Built-in HA tools in {{site.data.keyword.containerlong_notm}} balance the workload within each geographic region, including self-healing and load balancing.

**Step 3: Analyze and prevent fraud**
* Deploy IBM Watson for Financial Services to prevent and detect fraud.
* Using the toolchains and Helm deployment tools, the apps are also deployed to {{site.data.keyword.containerlong_notm}} clusters across the globe, so workloads and data meet regional regulations. 

**Results**
* Lifting the existing monolithic VMs into cloud-hosted containers was a first step that allowed the Dev Exec to save on capital and operations costs.
* With infrastructure management taken care of by IBM, the dev team was freed up to deliver updates 10x daily. 
* In parallel, the provider implemented simple time-boxed iterations to get a handle on the existing technical debt.
* With the number of transactions they process, they can scale their operations exponentially.
* At the same time, new fraud analysis with Watson increased the speed of detection and prevention, reducing fraud 4x more than the region’s average. 


