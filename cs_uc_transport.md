---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Transportation use cases for IBM Cloud
{: #cs_uc_transport}

These use cases highlight how workloads on {{site.data.keyword.containerlong_notm}} can 
take advantage of Watson AI for personalization, toolchains for rapid app updates, multiregion deployments across the globe, connections to existing back-end systems, and IOT data with IBM Event Streams. 

{: shortdesc}

## Shipping company increases availability of world-wide systems for partner ecosystem
{: #uc_shipping}

An IT Exec has WW ship routing and scheduling systems that partners interact with. Partners require up-to-the-minute information from these systems that access IoT device data. But, these systems were unable to scale across geographies with sufficient HA.
 
 Why IBM Cloud: IBM Cloud Kubernetes Service scales containerized apps with five 9s of availability to meet growing demands. App deployments occur 40 times daily when developers experiment easily, pushing changes to Dev and Test systems quickly. The IoT Platform makes access to IoT data easy. 
 
Key technologies:    
* Multi-regions for partner ecosystem 
* Horizontal scaling
* Open toolchains in IBM Cloud Continuous Delivery
* Cloud services for innovation
* IBM Event Streams to feed event data to apps

**Context: Shipping company increases availability of world-wide systems for partner ecosystem**

* Regional differences for shipping logistics made it difficult to keep up with growing number of partners in multiple countries, especially unique regulations and transit logistics, while maintaining consistent records. 
* Just-in-time data meant the world-wide systems must be highly available to reduce lags in transit operations. Time tables for ship terminals are highly controlled and in some cases inflexible. Web usage will be high, so instability could cause poor user experience. 
* Developers needed to constantly evolve apps, but traditional tools slowed their ability to deploy updates and features frequently.  

**The solution**

The shipping company wants a cohesive way to manage shipping time tables, inventories, and customs paperwork, so that they can accurately share location of shipments, shipping contents, and delivery schedules to their customers. They’re taking the guess work out of when a good (such as an appliance, clothing, or produce) will arrive, so that their shipping customers can communicate that to their own customers. 

The solution is made up of these primary components: 
1. Streaming data from IoT devices for each shipping container: manifests and location
2. Customs paperwork that’s digitally shared with applicable ports and transit partners, including access control
3. App for shipping customers that aggregates and communicates arrival information for shipped goods, including APIs for shipping customers to reuse shipment data in their own retail and B2B apps

For the shipping company to work with global partners, the routing and scheduling systems required local modifications to fit each region’s language, regulations, and unique port logistics. {{site.data.keyword.containerlong_notm}} offers global coverage in multiple regions, including North America, Europe, Asia, and Australia, so that the company’s apps reflected the needs of its partners, in each country.

IoT devices stream data that IBM Event Streams distributes to the regional port apps and associated Customs and Container manifest data stores. IBM Event Streams can act as the landing point for IoT events and can distribute them across the platform for app developers because of the managed connectivity that the Watson IoT Platform offers to IBM Event Streams.

After these events are available in IBM Event Streams, they are persisted making them both immediately available for port transit apps but also at any point in the future. Apps that require the lowest latency consume directly in real time from the event stream (IBM Event Streams). Other future apps, such as analytics tools, can choose to consume in a batch mode from the event store via IBM Cloud Object Storage.

Since shipping data must be shareable with the company’s customers, the developers are responsible for APIs that the company’s customers can use to surface shipping information onto their apps, such as mobile tracking apps or web e-commerce solutions. The developers are also busy with building and maintaining the regional port apps that gather and disseminate the customs records and shipping manifests. In short, they need to focus on coding instead of managing the infrastructure. Thus, they chose {{site.data.keyword.containerlong_notm}} because IBM simplifies infrastructure management:
* Managing Kubernetes master, IaaS, and operational components, such as Ingress and storage
* Monitoring health and recovery for worker nodes
* Providing global compute, so developers don’t have to stand up infrastructure in geographies where they need workloads and data to reside

To achieve global availability, the Dev, Test, and Production systems were deployed across the globe in several data centers. For HA, they use a combination of multiple clusters in multiple geographic regions as well as multizone clusters. They can easily deploy the port app to Frankfort clusters to comply with the local European regulations and also deploy the port app within the United States clusters to ensure local availability and failure recovery. 

They also spread the workload across multizone clusters in Frankfurt to ensure that the European version of the app is available and also balances the workload efficiently. Because each region uploads unique data with the port app, the app’s clusters are hosted in regions where latency is low.

For developers, much of the CI/CD process can be automated with IBM Cloud Continuous Delivery. The company can define workflow toolchains to prepare container images, check for vulnerabilities, and deploy them to the Kubernetes cluster. 

**Solution model**

On-demand compute, storage, and event management running in public cloud with access to shipment data across the globe, as warranted.

Technical solution:
* IBM Cloud Kubernetes Service
* IBM Event Streams
* IBM Cloud Object Storage
* IBM Continuous Delivery

**Step 1: Containerize apps using microservices**

* Architect apps into a set of cooperative microservices running within {{site.data.keyword.containerlong_notm}} based on functional areas of the app and its dependencies.
* Deploy apps to containers running in IBM Cloud Kubernetes Service. 
* Provide standardized DevOps dashboards through Kubernetes.
* Enables on-demand scaling of compute for batch and other inventory workloads that run infrequently.
* Use IBM Event Streams to manage streaming data from IoT devices.

**Step 2: Ensure global availability**
* Built-in HA tools in {{site.data.keyword.containerlong_notm}} balance the workload within each geographic region, including self-healing and load balancing.
* Load-balancing, firewalls, and DNS are handled by IBM Cloud Internet Services. 
* Using the toolchains and Helm deployment tools, the apps are also deployed to clusters across the globe, so workloads and data meet regional requirements. 

**Step 3: Share data**
* IBM Cloud Object Storage plus IBM Event Streams provides real-time and historically data storage. 
* APIs allow the shipping company’s customers to share data into their apps.

**Step 4: Deliver continuously**
* IBM Continuous Delivery helps developers to quickly provision an integrated toolchain using customizable, shareable templates with tools from IBM, third parties, and open source. Automate builds and tests, controlling quality with analytics.
* After developers build and test the apps in their Dev and Test clusters, they use the IBM CI/CD toolchains to deploy apps into clusters across the globe. 
* {{site.data.keyword.containerlong_notm}} provides easy roll-out and roll-back of apps; tailored apps are deployed to meet regional requirements through Istio’s intelligent routing and load balancing. 

**Results**

* With {{site.data.keyword.containerlong_notm}} and IBM CI/CD tools, regional versions of apps are hosted near to the physical devices that they gather data from. 
* Microservices greatly reduce time to delivery for patches, bug fixes, and new features. Initial development is fast, and updates are frequent.
* Shipping customers have real-time access to shipments’ locations, delivery schedules, and even approved port records.
* Transit partners at a variety of shipping terminals are aware of manifests and shipment details, so that onsite logistics are improved, instead of delayed. 
* Separately from this story, [Maersk and IBM formed a joint venture](https://www.ibm.com/press/us/en/pressrelease/53602.wss) to improve international supply chains with Blockchain. 

## Airline delivers innovative HR benefits site in under 3 weeks
{: #uc_airline}

An HR Exec (CHRO) needs a new HR benefits site with an innovative chat bot, but current Dev tools and platform mean long lead times for apps to go live. This includes waiting for hardware procurement.

Why IBM Cloud: IBM Cloud Kubernetes Service provides easy spin-up of compute. Then, developers can experiment easily, pushing changes to Dev and Test systems quickly with open toolchains. Their traditional software development tools get a boost when they add on IBM Watson Assistant. The new benefits site was created in less than 3 weeks.

Key technologies:    
* Design clusters to fit CPU, RAM, storage needs
* Chatbot service powered by Watson
* DevOps native tools, including open toolchains in IBM Cloud Continuous Delivery
* SDK for Node.js

**Context: Rapidly building and deploying innovative HR benefits site in less than 3 weeks**
* Employee growth and changing HR policies meant that a whole new site would be required for annual enrollment. 
* Interactive features, such as a chat bot, were expected to help communicate new HR policies to existing employees.
* Due to growth in number employees, the site traffic would increase, but their infrastructure budget remained flat. 
* The HR team faced pressure to move faster—roll out new site features quickly and post last-minute benefit changes frequently. 
* The enrollment period lasts for two weeks, therefore downtime for the new app could not be tolerated.

**The solution**

The airline wants to design an open culture that puts people first. The HR Exec is well aware that a focus on incenting and retaining talent will impact the airline’s bottom line. Thus, the annual rollout of benefits is a key aspect of fostering an employee-centered culture.  

They need a solution that could help the developers and their end users:
* FRONT-END TO EXISTING BENEFITS: insurance, educational offerings, wellness, and more
* REGION-SPECIFIC FEATURES: each country has unique HR policies, so that the overall site might look similar but show region-specific benefits
* DEVELOPER-FRIENDLY TOOLS that accelerate roll-out of features and bug fixes 
* CHATBOT to provide authentic conversations about benefits and resolve users requests and questions efficiently.

Technical solution:
* IBM Cloud Kubernetes Service
* IBM Watson Assistant and Tone Analyzer
* IBM Cloud Continuous Delivery
* IBM Logging and Monitoring
* IBM Secure Gateway

Accelerated development is a key win for the HR Exec. The team gets started by containerizing their apps and putting them in the cloud. With the use of modern containers, developers can experiment easily with Node.js SDK, pushing changes to Dev and Test systems, scaled out on separate clusters. Those pushes were automated with open toolchains and IBM Cloud Continuous Delivery. No longer were updates to the HR site languishing in slow, error-prone build processes. They can deliver incremental updates to their site, daily or even more frequently.  Moreover logging and monitoring for the HR site, especially how the site pulled personalize data out of back-end benefit systems, comes out of the box. evelopers don’t waste time building complex logging systems, just to be able to troubleshoot live systems.

With {{site.data.keyword.containerlong_notm}}, they went from over-built hardware in a private data center to customizable compute that reduces IT operations, maintenance, and energy. To host the HR site, they could easily design Kubernetes clusters to fit their CPU, RAM, and storage needs. Another factor for lower manpower costs is that IBM manages Kubernetes, so the developers can focus on delivering better employee experience for benefits enrollment.

{{site.data.keyword.containerlong_notm}} provides scalable compute resources and the associated DevOps dashboards to create, scale, and tear down apps and services on demand. Using industry-standard containers technology apps can be quickly developed and shared across multiple dev, test, and prod environments. This provides the immediate benefit of scalability. Using Kubernetes rich set of deployment & runtime objects, the HR team will be able to monitor & manage upgrades to apps reliably. They will also be able to replicate and scale the apps using defined rules and the automated Kubernetes orchestrator.

**Step 1: Containers, microservices, and the Garage Method**
* Apps are built in a set of cooperative microservices running within {{site.data.keyword.containerlong_notm}} based on functional areas of the app with the most quality problems.
* Deploy apps to container running in IBM Cloud Kubernetes Service, continuously scanned with IBM Vulnerability Advisor. 
* Provide standardized DevOps dashboards through Kubernetes.
* Adopt the essential agile and iterative development practices within the IBM Garage Method to enable frequent releases of new functions, patches, and fixes without downtime. 

**Step 2: Connections to existing benefits back-end**
* IBM Secure Gateway is used to create a secure tunnel to on-prem systems that host the benefits systems.  
* Combination of on-prem data and {{site.data.keyword.containerlong_notm}} allows you to leverage sensitive data to provider deeper support while adhering to regulations.
* Chatbot conversations fed back into HR policies, allowing the benefits site to reflect which benefits were most and least popular, including targeted improvements to poorly performing initiatives.

**Step 3: Chatbot and personalization**
* IBM Watson Assistant provides the tooling to quickly scaffold a chatbot that can provide the right benefits information to users.
* Watson Tone Analyzer ensures that customers are satisfied with the chatbot conversations and take human intervention when necessary. 

**Step 4: Deliver continuously across the globe**
* IBM Cloud Continuous Delivery helps developers to quickly provision an integrated toolchain using customizable, shareable templates with tools from IBM, third parties, and open source. Automate builds and tests, controlling quality with analytics.
* After developers build and test the apps in their Dev and Test clusters, they use the IBM CI/CD toolchains to deploy apps into production clusters across the globe. 
* {{site.data.keyword.containerlong_notm}} provides easy roll-out and roll-back of apps; tailored apps are deployed to meet regional requirements through Istio’s intelligent routing and load balancing. 
* Built-in HA tools in {{site.data.keyword.containerlong_notm}} balance the workload within each geographic region, including self-healing and load balancing.

**Results**
* With tools like the chat bot, the HR team proved to their workforce that innovation was part of the corporate culture, not just buzz words. 
* Authenticity with personalization in the site addressed the changing expectations of the airline’s workforce today. 
* Last-minute updates to the HR site, including ones driven by the employees chat bot conversations, went live quickly because developers were pushing changes at least 10 times daily. 
* With infrastructure management taken care of by IBM, the dev team was freed up to deliver the site in only 3 weeks. 


