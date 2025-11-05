---

copyright:
  years: 2024, 2025

lastupdated: "2025-11-05"


keywords: change log, version history, Ingress ALB

subcollection: "containers"

---

{{site.data.keyword.attribute-definition-list}}




# Ingress ALB
{: #cl-ingress-alb}

Review the version history for Ingress ALB.
{: shortdesc}



## Version 1.13.2
{: #cl-ingress-alb-1.13.2}


### 1.13.2_7820_iks, released 16 September 2025
{: #cl-ingress-alb-1132_7820_iks}


### 1.13.2_291202775_iks, released 28 October 2025
{: #cl-ingress-alb-1132_291202775_iks}


### 1.13.2_288662581_iks, released 14 October 2025
{: #cl-ingress-alb-1132_288662581_iks}




## Version 1.12.1
{: #cl-ingress-alb-1.12.1}


### 1.12.1_7792_iks, released 21 August 2025
{: #cl-ingress-alb-1121_7792_iks}


### 1.12.1_7742_iks, released 16 July 2025
{: #cl-ingress-alb-1121_7742_iks}

- Resolves the following CVEs: [CVE-2025-5222](https://nvd.nist.gov/vuln/detail/CVE-2025-5222){: external}.

### 1.12.1_7702_iks, released 15 July 2025
{: #cl-ingress-alb-1121_7702_iks}


### 1.12.1_7643_iks, released 17 June 2025
{: #cl-ingress-alb-1121_7643_iks}

- Resolves the following CVEs: [CVE-2025-22872](https://nvd.nist.gov/vuln/detail/CVE-2025-22872){: external}.

### 1.12.1_7581_iks, released 21 May 2025
{: #cl-ingress-alb-1121_7581_iks}

- Resolves the following CVEs: [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, and [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}.

### 1.12.1_7545_iks, released 08 May 2025
{: #cl-ingress-alb-1121_7545_iks}

- Resolves the following CVEs: [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, and [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}.

### 1.12.1_7518_iks, released 22 April 2025
{: #cl-ingress-alb-1121_7518_iks}

- Resolves the following CVEs: [CVE-2025-31498](https://nvd.nist.gov/vuln/detail/CVE-2025-31498){: external}, and [CVE-2025-31115](https://nvd.nist.gov/vuln/detail/CVE-2025-31115){: external}.

### 1.12.1_7490_iks, released 02 April 2025
{: #cl-ingress-alb-1121_7490_iks}

- Resolves the following CVEs: [CVE-2025-1097](https://nvd.nist.gov/vuln/detail/CVE-2025-1097){: external}, [CVE-2025-1098](https://nvd.nist.gov/vuln/detail/CVE-2025-1098){: external}, [CVE-2025-1974](https://nvd.nist.gov/vuln/detail/CVE-2025-1974){: external}, [CVE-2025-24513](https://nvd.nist.gov/vuln/detail/CVE-2025-24513){: external}, and [CVE-2025-24514](https://nvd.nist.gov/vuln/detail/CVE-2025-24514){: external}.
- Global rate-limiting is no longer available. The `nginx.ingress.kubernetes.io/global-rate-limit-memcached-host`, `nginx.ingress.kubernetes.io/global-rate-limit-memcached-port`, `nginx.ingress.kubernetes.io/global-rate-limit-memcached-connect-timeout`, `nginx.ingress.kubernetes.io/global-rate-limit-memcached-max-idle-timeout`, `nginx.ingress.kubernetes.io/global-rate-limit-memcached-pool-size`, `nginx.ingress.kubernetes.io/global-rate-limit-status-code`, `nginx.ingress.kubernetes.io/global-rate-limit`, `nginx.ingress.kubernetes.io/global-rate-limit-window`, `nginx.ingress.kubernetes.io/global-rate-limit-key` and `nginx.ingress.kubernetes.io/global-rate-limit-ignored-cidrs` annotations will be ignored by the Ingress Controller. For rate-limiting, use the `nginx.ingress.kubernetes.io/limit-connections`, `nginx.ingress.kubernetes.io/limit-rps`, `nginx.ingress.kubernetes.io/limit-rpm`, `nginx.ingress.kubernetes.io/limit-burst-multiplier`, `nginx.ingress.kubernetes.io/limit-rate-after`, `nginx.ingress.kubernetes.io/limit-whitelist` and `nginx.ingress.kubernetes.io/limit-rate` annotations.
- The `nginx_ingress_controller_ingress_upstream_latency_seconds` metric has been removed, use `nginx_ingress_controller_connect_duration_seconds` instead.

### 1.12.1_291242242_iks, released 28 October 2025
{: #cl-ingress-alb-1121_291242242_iks}

[Default version]{: tag-green}


### 1.12.1_288662251_iks, released 14 October 2025
{: #cl-ingress-alb-1121_288662251_iks}

- Resolves the following CVEs: [CVE-2025-49794](https://nvd.nist.gov/vuln/detail/CVE-2025-49794){: external}, [CVE-2025-49795](https://nvd.nist.gov/vuln/detail/CVE-2025-49795){: external}, [CVE-2025-49796](https://nvd.nist.gov/vuln/detail/CVE-2025-49796){: external}, [CVE-2025-6021](https://nvd.nist.gov/vuln/detail/CVE-2025-6021){: external}, [CVE-2025-6170](https://nvd.nist.gov/vuln/detail/CVE-2025-6170){: external}, [CVE-2025-10148](https://nvd.nist.gov/vuln/detail/CVE-2025-10148){: external}, [CVE-2025-4947](https://nvd.nist.gov/vuln/detail/CVE-2025-4947){: external}, [CVE-2025-5025](https://nvd.nist.gov/vuln/detail/CVE-2025-5025){: external}, [CVE-2025-5399](https://nvd.nist.gov/vuln/detail/CVE-2025-5399){: external}, and [CVE-2025-9086](https://nvd.nist.gov/vuln/detail/CVE-2025-9086){: external}.



## Version 1.11.2
{: #cl-ingress-alb-1.11.2}


### 1.11.2_7782_iks, released 18 August 2025
{: #cl-ingress-alb-1112_7782_iks}


### 1.11.2_7740_iks, released 21 July 2025
{: #cl-ingress-alb-1112_7740_iks}

- Resolves the following CVEs: [CVE-2025-5222](https://nvd.nist.gov/vuln/detail/CVE-2025-5222){: external}.

### 1.11.2_7732_iks, released 16 July 2025
{: #cl-ingress-alb-1112_7732_iks}

- Resolves the following CVEs: [CVE-2025-5222](https://nvd.nist.gov/vuln/detail/CVE-2025-5222){: external}.

### 1.11.2_7701_iks, released 15 July 2025
{: #cl-ingress-alb-1112_7701_iks}


### 1.11.2_7646_iks, released 17 June 2025
{: #cl-ingress-alb-1112_7646_iks}

- Resolves the following CVEs: [CVE-2025-22872](https://nvd.nist.gov/vuln/detail/CVE-2025-22872){: external}.

### 1.11.2_7579_iks, released 21 May 2025
{: #cl-ingress-alb-1112_7579_iks}

- Resolves the following CVEs: [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, and [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}.

### 1.11.2_7546_iks, released 08 May 2025
{: #cl-ingress-alb-1112_7546_iks}

- Resolves the following CVEs: [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, and [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}.

### 1.11.2_7500_iks, released 22 April 2025
{: #cl-ingress-alb-1112_7500_iks}

- Resolves the following CVEs: [CVE-2025-31115](https://nvd.nist.gov/vuln/detail/CVE-2025-31115){: external}.

### 1.11.2_7469_iks, released 25 March 2025
{: #cl-ingress-alb-1112_7469_iks}

- Resolves the following CVEs: [CVE-2025-22870](https://nvd.nist.gov/vuln/detail/CVE-2025-22870){: external}.

### 1.11.2_7452_iks, released 17 March 2025
{: #cl-ingress-alb-1112_7452_iks}

- Resolves the following CVEs: [CVE-2025-27113](https://nvd.nist.gov/vuln/detail/CVE-2025-27113){: external}, [CVE-2024-56171](https://nvd.nist.gov/vuln/detail/CVE-2024-56171){: external}, and [CVE-2025-24928](https://nvd.nist.gov/vuln/detail/CVE-2025-24928){: external}.

### 1.11.2_7418_iks, released 07 March 2025
{: #cl-ingress-alb-1112_7418_iks}

- Resolves the following CVEs: [CVE-2025-22868](https://nvd.nist.gov/vuln/detail/CVE-2025-22868){: external}, and [CVE-2025-22869](https://nvd.nist.gov/vuln/detail/CVE-2025-22869){: external}.
- Updates Go to version `1.23.6`.

### 1.11.2_7356_iks, released 26 February 2025
{: #cl-ingress-alb-1112_7356_iks}

- Resolves the following CVEs: [CVE-2024-12797](https://nvd.nist.gov/vuln/detail/CVE-2024-12797){: external}, and [CVE-2024-13176](https://nvd.nist.gov/vuln/detail/CVE-2024-13176){: external}.

### 1.11.2_7300_iks, released 08 January 2025
{: #cl-ingress-alb-1112_7300_iks}

- Resolves the following CVEs: [CVE-2024-45338](https://nvd.nist.gov/vuln/detail/CVE-2024-45338){: external}, and [CVE-2024-45337](https://nvd.nist.gov/vuln/detail/CVE-2024-45337){: external}.

### 1.11.2_7213_iks, released 03 December 2024
{: #cl-ingress-alb-1112_7213_iks}

- Resolves the following CVEs: [CVE-2024-9681](https://nvd.nist.gov/vuln/detail/CVE-2024-9681){: external}.

### 1.11.2_7190_iks, released 30 October 2024
{: #cl-ingress-alb-1112_7190_iks}

- Resolves the following CVEs: [CVE-2024-9143](https://nvd.nist.gov/vuln/detail/CVE-2024-9143){: external}.

### 1.11.2_7174_iks, released 14 October 2024
{: #cl-ingress-alb-1112_7174_iks}

- fix duplicate header nginx logs 

### 1.11.2_7140_iks, released 23 September 2024
{: #cl-ingress-alb-1112_7140_iks}

- Resolves the following CVEs: [CVE-2024-8096](https://nvd.nist.gov/vuln/detail/CVE-2024-8096){: external}, and [CVE-2024-45310](https://nvd.nist.gov/vuln/detail/CVE-2024-45310){: external}.

### 1.11.2_7133_iks, released 12 September 2024
{: #cl-ingress-alb-1112_7133_iks}

- Resolves the following CVEs: [CVE-2024-45310](https://nvd.nist.gov/vuln/detail/CVE-2024-45310){: external}, and [CVE-2024-6119](https://nvd.nist.gov/vuln/detail/CVE-2024-6119){: external}.
- Updates Go to version `1.22.7`.

### 1.11.2_7069_iks, released 04 September 2024
{: #cl-ingress-alb-1112_7069_iks}

- add v1.11.2 Ingress NGINX Controller

### 1.11.2_291246358_iks, released 28 October 2025
{: #cl-ingress-alb-1112_291246358_iks}


### 1.11.2_288648329_iks, released 14 October 2025
{: #cl-ingress-alb-1112_288648329_iks}

- Resolves the following CVEs: [CVE-2025-49794](https://nvd.nist.gov/vuln/detail/CVE-2025-49794){: external}, [CVE-2025-49795](https://nvd.nist.gov/vuln/detail/CVE-2025-49795){: external}, [CVE-2025-49796](https://nvd.nist.gov/vuln/detail/CVE-2025-49796){: external}, [CVE-2025-6021](https://nvd.nist.gov/vuln/detail/CVE-2025-6021){: external}, [CVE-2025-6170](https://nvd.nist.gov/vuln/detail/CVE-2025-6170){: external}, [CVE-2025-10148](https://nvd.nist.gov/vuln/detail/CVE-2025-10148){: external}, [CVE-2025-4947](https://nvd.nist.gov/vuln/detail/CVE-2025-4947){: external}, [CVE-2025-5025](https://nvd.nist.gov/vuln/detail/CVE-2025-5025){: external}, [CVE-2025-5399](https://nvd.nist.gov/vuln/detail/CVE-2025-5399){: external}, and [CVE-2025-9086](https://nvd.nist.gov/vuln/detail/CVE-2025-9086){: external}.



## Version 1.9.6
{: #cl-ingress-alb-1.9.6}


### 1.9.6_7781_iks, released 18 August 2025
{: #cl-ingress-alb-196_7781_iks}


### 1.9.6_7741_iks, released 16 July 2025
{: #cl-ingress-alb-196_7741_iks}

- Resolves the following CVEs: [CVE-2025-5222](https://nvd.nist.gov/vuln/detail/CVE-2025-5222){: external}.

### 1.9.6_7700_iks, released 15 July 2025
{: #cl-ingress-alb-196_7700_iks}


### 1.9.6_7645_iks, released 17 June 2025
{: #cl-ingress-alb-196_7645_iks}

- Resolves the following CVEs: [CVE-2025-22872](https://nvd.nist.gov/vuln/detail/CVE-2025-22872){: external}.

### 1.9.6_7580_iks, released 21 May 2025
{: #cl-ingress-alb-196_7580_iks}

- Resolves the following CVEs: [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, and [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}.

### 1.9.6_7544_iks, released 08 May 2025
{: #cl-ingress-alb-196_7544_iks}

- Resolves the following CVEs: [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, and [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}.

### 1.9.6_7513_iks, released 22 April 2025
{: #cl-ingress-alb-196_7513_iks}

- Resolves the following CVEs: [CVE-2025-31115](https://nvd.nist.gov/vuln/detail/CVE-2025-31115){: external}.

### 1.9.6_7468_iks, released 25 March 2025
{: #cl-ingress-alb-196_7468_iks}

- Resolves the following CVEs: [CVE-2025-22870](https://nvd.nist.gov/vuln/detail/CVE-2025-22870){: external}.

### 1.9.6_7453_iks, released 17 March 2025
{: #cl-ingress-alb-196_7453_iks}

- Resolves the following CVEs: [CVE-2025-27113](https://nvd.nist.gov/vuln/detail/CVE-2025-27113){: external}, [CVE-2024-56171](https://nvd.nist.gov/vuln/detail/CVE-2024-56171){: external}, and [CVE-2025-24928](https://nvd.nist.gov/vuln/detail/CVE-2025-24928){: external}.

### 1.9.6_7425_iks, released 11 March 2025
{: #cl-ingress-alb-196_7425_iks}

- Resolves the following CVEs: [CVE-2025-22869](https://nvd.nist.gov/vuln/detail/CVE-2025-22869){: external}, and [CVE-2025-22868](https://nvd.nist.gov/vuln/detail/CVE-2025-22868){: external}.

### 1.9.6_7357_iks, released 26 February 2025
{: #cl-ingress-alb-196_7357_iks}

- Resolves the following CVEs: [CVE-2024-13176](https://nvd.nist.gov/vuln/detail/CVE-2024-13176){: external}, [CVE-2025-0167](https://nvd.nist.gov/vuln/detail/CVE-2025-0167){: external}, [CVE-2025-0665](https://nvd.nist.gov/vuln/detail/CVE-2025-0665){: external}, [CVE-2025-0725](https://nvd.nist.gov/vuln/detail/CVE-2025-0725){: external}, and [CVE-2025-26519](https://nvd.nist.gov/vuln/detail/CVE-2025-26519){: external}.

### 1.9.6_7309_iks, released 13 January 2025
{: #cl-ingress-alb-196_7309_iks}

- Resolves the following CVEs: [CVE-2024-11053](https://nvd.nist.gov/vuln/detail/CVE-2024-11053){: external}, [CVE-2024-8096](https://nvd.nist.gov/vuln/detail/CVE-2024-8096){: external}, and [CVE-2024-9681](https://nvd.nist.gov/vuln/detail/CVE-2024-9681){: external}.

### 1.9.6_7296_iks, released 08 January 2025
{: #cl-ingress-alb-196_7296_iks}

- Resolves the following CVEs: [CVE-2024-45338](https://nvd.nist.gov/vuln/detail/CVE-2024-45338){: external}, and [CVE-2024-45337](https://nvd.nist.gov/vuln/detail/CVE-2024-45337){: external}.

### 1.9.6_7189_iks, released 30 October 2024
{: #cl-ingress-alb-196_7189_iks}

- Resolves the following CVEs: [CVE-2024-9143](https://nvd.nist.gov/vuln/detail/CVE-2024-9143){: external}, and [CVE-2024-45310](https://nvd.nist.gov/vuln/detail/CVE-2024-45310){: external}.

### 1.9.6_7132_iks, released 12 September 2024
{: #cl-ingress-alb-196_7132_iks}

- Resolves the following CVEs: [CVE-2024-45310](https://nvd.nist.gov/vuln/detail/CVE-2024-45310){: external}, and [CVE-2024-6119](https://nvd.nist.gov/vuln/detail/CVE-2024-6119){: external}.
- Updates Go to version `1.22.7`.

### 1.9.6_7029_iks, released 27 August 2024
{: #cl-ingress-alb-196_7029_iks}

- Resolves the following CVEs: [CVE-2024-2466](https://nvd.nist.gov/vuln/detail/CVE-2024-2466){: external}, [CVE-2024-2398](https://nvd.nist.gov/vuln/detail/CVE-2024-2398){: external}, [CVE-2024-2379](https://nvd.nist.gov/vuln/detail/CVE-2024-2379){: external}, [CVE-2024-2004](https://nvd.nist.gov/vuln/detail/CVE-2024-2004){: external}, [CVE-2024-0853](https://nvd.nist.gov/vuln/detail/CVE-2024-0853){: external}, [CVE-2024-6874](https://nvd.nist.gov/vuln/detail/CVE-2024-6874){: external}, and [CVE-2024-6197](https://nvd.nist.gov/vuln/detail/CVE-2024-6197){: external}.

### 1.9.6_6846_iks, released 11 July 2024
{: #cl-ingress-alb-196_6846_iks}

- Resolves the following CVEs: [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}, and [CVE-2024-4741](https://nvd.nist.gov/vuln/detail/CVE-2024-4741){: external}.

### 1.9.6_6779_iks, released 20 June 2024
{: #cl-ingress-alb-196_6779_iks}

- Resolves the following CVEs: [CVE-2023-42365](https://nvd.nist.gov/vuln/detail/CVE-2023-42365){: external}, [CVE-2023-42364](https://nvd.nist.gov/vuln/detail/CVE-2023-42364){: external}, and [CVE-2023-33460](https://nvd.nist.gov/vuln/detail/CVE-2023-33460){: external}.
- Updates Go to version `1.22.4`.

### 1.9.6_6650_iks, released 30 May 2024
{: #cl-ingress-alb-196_6650_iks}

- Resolves the following CVEs: [CVE-2023-42363](https://nvd.nist.gov/vuln/detail/CVE-2023-42363){: external}, [CVE-2023-42364](https://nvd.nist.gov/vuln/detail/CVE-2023-42364){: external}, [CVE-2023-42365](https://nvd.nist.gov/vuln/detail/CVE-2023-42365){: external}, [CVE-2023-42366](https://nvd.nist.gov/vuln/detail/CVE-2023-42366){: external}, [CVE-2024-34459](https://nvd.nist.gov/vuln/detail/CVE-2024-34459){: external}, and [CVE-2024-4603](https://nvd.nist.gov/vuln/detail/CVE-2024-4603){: external}.

### 1.9.6_6634_iks, released 18 May 2024
{: #cl-ingress-alb-196_6634_iks}

- Updates Go to version `1.22.3`.

### 1.9.6_6587_iks, released 03 May 2024
{: #cl-ingress-alb-196_6587_iks}

- Resolves the following CVEs: [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.

### 1.9.6_6547_iks, released 17 April 2024
{: #cl-ingress-alb-196_6547_iks}

- Resolves the following CVEs: [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}, and [CVE-2024-25629](https://nvd.nist.gov/vuln/detail/CVE-2024-25629){: external}.
- Updates Go to version `1.22.2`.

### 1.9.6_6505_iks, released 08 April 2024
{: #cl-ingress-alb-196_6505_iks}

- Resolves the following CVEs: [CVE-2024-25629](https://nvd.nist.gov/vuln/detail/CVE-2024-25629){: external}.
- Updates Go to version `1.22.1`.

### 1.9.6_6450_iks, released 18 March 2024
{: #cl-ingress-alb-196_6450_iks}

- Resolves the following CVEs: [CVE-2024-24786](https://nvd.nist.gov/vuln/detail/CVE-2024-24786){: external}.
- CVE-2024-24786 
- Initial release of 1.9.6. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.9.6)



## Version 1.9.4
{: #cl-ingress-alb-1.9.4}


### 1.9.4_7028_iks, released 27 August 2024
{: #cl-ingress-alb-194_7028_iks}

- Resolves the following CVEs: [CVE-2024-6197](https://nvd.nist.gov/vuln/detail/CVE-2024-6197){: external}, [CVE-2024-2466](https://nvd.nist.gov/vuln/detail/CVE-2024-2466){: external}, [CVE-2024-2398](https://nvd.nist.gov/vuln/detail/CVE-2024-2398){: external}, [CVE-2024-2379](https://nvd.nist.gov/vuln/detail/CVE-2024-2379){: external}, [CVE-2024-2004](https://nvd.nist.gov/vuln/detail/CVE-2024-2004){: external}, [CVE-2024-0853](https://nvd.nist.gov/vuln/detail/CVE-2024-0853){: external}, and [CVE-2024-6874](https://nvd.nist.gov/vuln/detail/CVE-2024-6874){: external}.

### 1.9.4_6848_iks, released 11 July 2024
{: #cl-ingress-alb-194_6848_iks}

- Resolves the following CVEs: [CVE-2024-4741](https://nvd.nist.gov/vuln/detail/CVE-2024-4741){: external}, and [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}.

### 1.9.4_6775_iks, released 20 June 2024
{: #cl-ingress-alb-194_6775_iks}

- Resolves the following CVEs: [CVE-2023-42365](https://nvd.nist.gov/vuln/detail/CVE-2023-42365){: external}, [CVE-2023-42364](https://nvd.nist.gov/vuln/detail/CVE-2023-42364){: external}, and [CVE-2023-42363](https://nvd.nist.gov/vuln/detail/CVE-2023-42363){: external}.
- Updates Go to version `1.22.4`.

### 1.9.4_6675_iks, released 30 May 2024
{: #cl-ingress-alb-194_6675_iks}

- Resolves the following CVEs: [CVE-2023-42366](https://nvd.nist.gov/vuln/detail/CVE-2023-42366){: external}, [CVE-2024-34459](https://nvd.nist.gov/vuln/detail/CVE-2024-34459){: external}, and [CVE-2024-4603](https://nvd.nist.gov/vuln/detail/CVE-2024-4603){: external}.

### 1.9.4_6633_iks, released 18 May 2024
{: #cl-ingress-alb-194_6633_iks}

- Updates Go to version `1.22.3`.

### 1.9.4_6586_iks, released 03 May 2024
{: #cl-ingress-alb-194_6586_iks}

- Resolves the following CVEs: [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.

### 1.9.4_6553_iks, released 17 April 2024
{: #cl-ingress-alb-194_6553_iks}

- Resolves the following CVEs: [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.
- Updates Go to version `1.22.2`.

### 1.9.4_6489_iks, released 08 April 2024
{: #cl-ingress-alb-194_6489_iks}

- Updates Go to version `1.22.1`.

### 1.9.4_6447_iks, released 18 March 2024
{: #cl-ingress-alb-194_6447_iks}

- Resolves the following CVEs: [CVE-2024-24786](https://nvd.nist.gov/vuln/detail/CVE-2024-24786){: external}.
- CVE-2024-24786 

### 1.9.4_6376_iks, released 26 February 2024
{: #cl-ingress-alb-194_6376_iks}

- Updates Go to version `1.22.0`.

### 1.9.4_6359_iks, released 22 February 2024
{: #cl-ingress-alb-194_6359_iks}

- Resolves the following CVEs: [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external}, [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}, [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}, [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626){: external}, and [CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795){: external}.
- Updates Go to version `1.21.5`.



## Version 1.8.5
{: #cl-ingress-alb-1.8.5}


### 1.8.5_7509_iks, released 22 April 2025
{: #cl-ingress-alb-185_7509_iks}

- Resolves the following CVEs: [CVE-2025-31115](https://nvd.nist.gov/vuln/detail/CVE-2025-31115){: external}.

### 1.8.5_7467_iks, released 25 March 2025
{: #cl-ingress-alb-185_7467_iks}

- Resolves the following CVEs: [CVE-2025-22870](https://nvd.nist.gov/vuln/detail/CVE-2025-22870){: external}.

### 1.8.5_7454_iks, released 17 March 2025
{: #cl-ingress-alb-185_7454_iks}

- Resolves the following CVEs: [CVE-2025-27113](https://nvd.nist.gov/vuln/detail/CVE-2025-27113){: external}, [CVE-2024-56171](https://nvd.nist.gov/vuln/detail/CVE-2024-56171){: external}, and [CVE-2025-24928](https://nvd.nist.gov/vuln/detail/CVE-2025-24928){: external}.

### 1.8.5_7417_iks, released 11 March 2025
{: #cl-ingress-alb-185_7417_iks}

- Resolves the following CVEs: [CVE-2025-22868](https://nvd.nist.gov/vuln/detail/CVE-2025-22868){: external}, and [CVE-2025-22869](https://nvd.nist.gov/vuln/detail/CVE-2025-22869){: external}.

### 1.8.5_7355_iks, released 26 February 2025
{: #cl-ingress-alb-185_7355_iks}

- Resolves the following CVEs: [CVE-2024-13176](https://nvd.nist.gov/vuln/detail/CVE-2024-13176){: external}.

### 1.8.5_7310_iks, released 13 January 2025
{: #cl-ingress-alb-185_7310_iks}

- Resolves the following CVEs: [CVE-2024-11053](https://nvd.nist.gov/vuln/detail/CVE-2024-11053){: external}, [CVE-2024-8096](https://nvd.nist.gov/vuln/detail/CVE-2024-8096){: external}, and [CVE-2024-9681](https://nvd.nist.gov/vuln/detail/CVE-2024-9681){: external}.

### 1.8.5_7295_iks, released 08 January 2025
{: #cl-ingress-alb-185_7295_iks}

- Resolves the following CVEs: [CVE-2024-45338](https://nvd.nist.gov/vuln/detail/CVE-2024-45338){: external}, and [CVE-2024-45337](https://nvd.nist.gov/vuln/detail/CVE-2024-45337){: external}.

### 1.8.5_7191_iks, released 30 October 2024
{: #cl-ingress-alb-185_7191_iks}

- Resolves the following CVEs: [CVE-2024-9143](https://nvd.nist.gov/vuln/detail/CVE-2024-9143){: external}.

### 1.8.5_7131_iks, released 12 September 2024
{: #cl-ingress-alb-185_7131_iks}

- Resolves the following CVEs: [CVE-2024-45310](https://nvd.nist.gov/vuln/detail/CVE-2024-45310){: external}, and [CVE-2024-6119](https://nvd.nist.gov/vuln/detail/CVE-2024-6119){: external}.
- Updates Go to version `1.22.7`.

### 1.8.5_7030_iks, released 27 August 2024
{: #cl-ingress-alb-185_7030_iks}

- Resolves the following CVEs: [CVE-2024-2466](https://nvd.nist.gov/vuln/detail/CVE-2024-2466){: external}, [CVE-2024-2398](https://nvd.nist.gov/vuln/detail/CVE-2024-2398){: external}, [CVE-2024-2379](https://nvd.nist.gov/vuln/detail/CVE-2024-2379){: external}, [CVE-2024-2004](https://nvd.nist.gov/vuln/detail/CVE-2024-2004){: external}, [CVE-2024-0853](https://nvd.nist.gov/vuln/detail/CVE-2024-0853){: external}, [CVE-2024-6874](https://nvd.nist.gov/vuln/detail/CVE-2024-6874){: external}, and [CVE-2024-6197](https://nvd.nist.gov/vuln/detail/CVE-2024-6197){: external}.

### 1.8.5_6847_iks, released 11 July 2024
{: #cl-ingress-alb-185_6847_iks}

- Resolves the following CVEs: [CVE-2024-4741](https://nvd.nist.gov/vuln/detail/CVE-2024-4741){: external}, and [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}.

### 1.8.5_6773_iks, released 20 June 2024
{: #cl-ingress-alb-185_6773_iks}

- Resolves the following CVEs: [CVE-2023-42365](https://nvd.nist.gov/vuln/detail/CVE-2023-42365){: external}, [CVE-2023-42364](https://nvd.nist.gov/vuln/detail/CVE-2023-42364){: external}, and [CVE-2023-42363](https://nvd.nist.gov/vuln/detail/CVE-2023-42363){: external}.
- Updates Go to version `1.22.4`.

### 1.8.5_6676_iks, released 30 May 2024
{: #cl-ingress-alb-185_6676_iks}

- Resolves the following CVEs: [CVE-2023-42366](https://nvd.nist.gov/vuln/detail/CVE-2023-42366){: external}, [CVE-2024-34459](https://nvd.nist.gov/vuln/detail/CVE-2024-34459){: external}, and [CVE-2024-4603](https://nvd.nist.gov/vuln/detail/CVE-2024-4603){: external}.

### 1.8.5_6632_iks, released 18 May 2024
{: #cl-ingress-alb-185_6632_iks}

- Updates Go to version `1.22.3`.

### 1.8.5_6585_iks, released 03 May 2024
{: #cl-ingress-alb-185_6585_iks}

- Resolves the following CVEs: [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.

### 1.8.5_6560_iks, released 17 April 2024
{: #cl-ingress-alb-185_6560_iks}

- Resolves the following CVEs: [CVE-2024-2511](https://nvd.nist.gov/vuln/detail/CVE-2024-2511){: external}, and [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.
- Updates Go to version `1.22.2`.

### 1.8.5_6488_iks, released 08 April 2024
{: #cl-ingress-alb-185_6488_iks}

- Updates Go to version `1.22.1`.

### 1.8.5_6449_iks, released 18 March 2024
{: #cl-ingress-alb-185_6449_iks}

- Resolves the following CVEs: [CVE-2024-24786](https://nvd.nist.gov/vuln/detail/CVE-2024-24786){: external}.
- CVE-2024-24786 
- Initial release of 1.8.5. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.8.5)



## Version 1.8.4
{: #cl-ingress-alb-1.8.4}


### 1.8.4_6375_iks, released 26 February 2024
{: #cl-ingress-alb-184_6375_iks}

- Updates Go to version `1.22.0`.

### 1.8.4_6363_iks, released 22 February 2024
{: #cl-ingress-alb-184_6363_iks}

- Resolves the following CVEs: [CVE-2024-25062](https://nvd.nist.gov/vuln/detail/CVE-2024-25062){: external}, [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external}, [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}, [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}, [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626){: external}, and [CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795){: external}.



## Version 1.6.4
{: #cl-ingress-alb-1.6.4}


### 1.6.4_6631_iks, released 18 May 2024
{: #cl-ingress-alb-164_6631_iks}

- Updates Go to version `1.22.3`.

### 1.6.4_6582_iks, released 03 May 2024
{: #cl-ingress-alb-164_6582_iks}

- Resolves the following CVEs: [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.

### 1.6.4_6555_iks, released 17 April 2024
{: #cl-ingress-alb-164_6555_iks}

- Resolves the following CVEs: [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external}.
- Updates Go to version `1.22.2`.

### 1.6.4_6487_iks, released 08 April 2024
{: #cl-ingress-alb-164_6487_iks}

- Updates Go to version `1.22.1`.

### 1.6.4_6448_iks, released 18 March 2024
{: #cl-ingress-alb-164_6448_iks}

- Resolves the following CVEs: [CVE-2024-24786](https://nvd.nist.gov/vuln/detail/CVE-2024-24786){: external}.
- CVE-2024-24786 

### 1.6.4_6374_iks, released 26 February 2024
{: #cl-ingress-alb-164_6374_iks}

- Updates Go to version `1.22.0`.

### 1.6.4_6344_iks, released 22 February 2024
{: #cl-ingress-alb-164_6344_iks}

- Resolves the following CVEs: [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626){: external}.




## Version 1.9.4 February 2024 and earlier
{: #1_9_4}

If your Ingress resources use configuration snippets or redirects, their behavior might change with v1.9.4. Validate your configuration before updating. For more information about version 1.9.4, see the [1.9.4 community change log](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.9.4){: external}.
{: important}

[Default version]{: tag-green}

1.9.4 is the default version for all ALBs that run the Kubernetes Ingress image. If you have Ingress auto update enabled, your ALBs automatically update to use this image.

### 1.9.4_6376_iks, released 26 February 2024
{: #1.9.4_6376_iks}

- Updates `golang` version to `1.22.0`.

### 1.9.4_6359_iks, released 19 February 2024
{: #1.9.4_6359_iks}

- Dependency updates.

### 1.9.4_6346_iks, released 13 February 2024
{: #1.9.4_6346_iks}

- Dependency updates.
- CVE remediation for [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626){: external}.


### 1.9.4_6292_iks, released 05 February 2024
{: #1.9.4_6292_iks}

- Dependency updates.
- CVE remediation for [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}.

### 1.9.4_6251_iks, released 22 January 2024
{: #1.9.4_6251_iks}

- Dependency updates.
- CVE remediation for [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external} and [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}.

### 1.9.4_6161_iks, released 10 January 2024
{: #1.9.4_6161_iks}

- Dependency updates.
- CVE remediation for [CVE-2023-46219](https://nvd.nist.gov/vuln/detail/CVE-2023-46219){: external} and [CVE-2023-46218](https://nvd.nist.gov/vuln/detail/CVE-2023-46218){: external}.


### 1.9.4_5886_iks, released 04 December 2023
{: #1.9.4_5886_iks}

- Dependency updates.


### 1.9.4_5756_iks, released 21 November 2023
{: #1.9.4_5756_iks}

- Fixes [CVE-2023-5678](https://nvd.nist.gov/vuln/detail/CVE-2023-5678){: external}.


### 1.9.4_5698_iks, released 07 November 2023
{: #1.9.4_5698_iks}

- Fixes [CVE-2023-5044](https://nvd.nist.gov/vuln/detail/CVE-2023-5044){: external}.

## Version 1.8.4 February 2024 and earlier
{: #1_8_4}

### 1.8.4_6375_iks, released 26 February 2024
{: #1.8.4_6375_iks}

- Updates `golang` version to `1.22.0`.

### 1.8.4_6363_iks, released 19 February 2024
{: #1.8.4_6363_iks}

- Dependency updates.
- CVE remediation for [CVE-2024-25062](https://nvd.nist.gov/vuln/detail/CVE-2024-25062){: external}.

### 1.8.4_6345_iks, released 13 February 2024
{: #1.8.4_6345_iks}

- Dependency updates.
- CVE remediation for [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626){: external}.

### 1.8.4_6291_iks, released 05 February 2024
{: #1.8.4_6291_iks}

- Dependency updates. 
- CVE remediation for [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}.


### 1.8.4_6245_iks, released 22 January 2024
{: #1.8.4_6245_iks}

- Dependency updates. 
- CVE remediation for [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external} and [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}.


### 1.8.4_6173_iks, released 10 January 2024
{: #1.8.4_6173_iks}

- Dependency updates.
- CVE remediation for [CVE-2023-46219](https://nvd.nist.gov/vuln/detail/CVE-2023-46219){: external} and [CVE-2023-46218](https://nvd.nist.gov/vuln/detail/CVE-2023-46218){: external}.


### 1.8.4_5885_iks, released 04 December 2023
{: #1.8.4_5885_iks}

- Dependency updates.

### 1.8.4_5757_iks, released 21 November 2023
{: #1.8.4_5757_iks}

- Fixes [CVE-2023-5678](https://nvd.nist.gov/vuln/detail/CVE-2023-5678){: external}.

### 1.8.4_5644_iks, released 07 November 2023
{: #1.8.4_5644_iks}

- Dependency updates.

### 1.8.4_5586_iks, released 23 October 2023
{: #1.8.4_5586_iks}

- Initial release of `1.8.4`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.8.4){: external}.
- Resolves [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}
- Updates `golang` version to `1.21.1`.

## Version 1.6.4 February 2024 and earlier
{: #1_6_4}

### 1.6.4_6374_iks, released 26 February 2024
{: #1.6.4_6374_iks}

- Updates `golang` version to `1.22.0`.

### 1.6.4_6344_iks, released 13 February 2024
{: #1.6.4_6344_iks}

- Dependency updates.
- CVE remediation for [CVE-2024-21626](https://nvd.nist.gov/vuln/detail/CVE-2024-21626){: external}.

### 1.6.4_6293_iks, released 05 February 2024
{: #1.6.4_6293_iks}

- Dependency updates. 
- CVE remediation for [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}.

### 1.6.4_6250_iks, released 22 January 2024
{: #1.6.4_6250_iks}

- Dependency updates. 
- CVE remediation for [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external} and [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}.

### 1.6.4_6177_iks, released 10 January 2024
{: #1.6.4_6177_iks}

- Dependency updates.
- CVE remediation for [CVE-2023-46219](https://nvd.nist.gov/vuln/detail/CVE-2023-46219){: external} and [CVE-2023-46218](https://nvd.nist.gov/vuln/detail/CVE-2023-46218){: external}.


### 1.6.4_5884_iks, released 04 December 2023
{: #1.6.4_5884_iks}

- Dependency updates.
- Fixes [CVE-2023-5678](https://nvd.nist.gov/vuln/detail/CVE-2023-5678){: external}.

### 1.6.4_5727_iks, released 21 November 2023
{: #1.6.4_5727_iks}

- Fixes [CVE-2023-5678](https://nvd.nist.gov/vuln/detail/CVE-2023-5678){: external}.

### 1.6.4_5642_iks, released 07 November 2023
{: #1.6.4_5642_iks}

- Dependency updates.

### 1.6.4_5544_iks, released 17 October 2023
{: #1.6.4_5544_iks}


- [CVE-2023-39325](https://nvd.nist.gov/vuln/detail/CVE-2023-39325){: external}
- [CVE-2023-38545](https://nvd.nist.gov/vuln/detail/CVE-2023-38545){: external}
- [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}
- [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}

### 1.6.4_5435_iks, released 11 October 2023
{: #1.6.4_5435_iks}

Go version update.

### 1.6.4_5406_iks, released 5 October 2023
{: #1.6.4_5406_iks}

- [CVE-2023-38039](https://nvd.nist.gov/vuln/detail/CVE-2023-38039){: external}
- [CVE-2023-39318](https://nvd.nist.gov/vuln/detail/CVE-2023-39318){: external}
- [CVE-2023-39319](https://nvd.nist.gov/vuln/detail/CVE-2023-39319){: external}

### 1.6.4_5270_iks, released 31 August 2023
{: #1.6.4_5270_iks}

- Resolves [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}
- Updates `golang` version to `1.20.7`.

### 1.6.4_5219_iks, released 26 July 2023
{: #1.6.4_5219_iks}

- [CVE-2023-35945](https://nvd.nist.gov/vuln/detail/CVE-2023-35945){: external}
- [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}

### 1.6.4_5161_iks, released 5 July 2023
{: #1.6.4_5161_iks}

- Resolves [CVE-2023-32731](https://nvd.nist.gov/vuln/detail/CVE-2023-32731){: external}

### 1.6.4_5067_iks, released 6 June 2023
{: #1.6.4_5067_iks}

- Updates `golang` version to `1.20.4`.
- [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}
- [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}

### 1.6.4_4170_iks, released 23 May 2023
{: #1.6.4_4170_iks}

- [CVE-2023-28319](https://nvd.nist.gov/vuln/detail/CVE-2023-28319){: external}
- [CVE-2023-28320](https://nvd.nist.gov/vuln/detail/CVE-2023-28320){: external}
- [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}
- [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}

### 1.6.4_4117_iks, released 4 May 2023
{: #1.6.4_4117_iks}

- Image update.

### 1.6.4_4073_iks, released 27 April 2023
{: #1.6.4_4073_iks}

- [CVE-2023-1255](https://nvd.nist.gov/vuln/detail/CVE-2023-1255){: external}
- [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}
- [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}

### 1.6.4_3976_iks, released 12 April 2023
{: #1.6.4_3976_iks}

Updates `golang` to version `1.20.3`.

### 1.6.4_3947_iks, released 4 April 2023
{: #1.6.4_3947_iks}

- [CVE-2023-25809](https://nvd.nist.gov/vuln/detail/CVE-2023-25809){: external}
- [CVE-2023-28642](https://nvd.nist.gov/vuln/detail/CVE-2023-28642){: external}
- [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}
- [CVE-2023-0465](https://nvd.nist.gov/vuln/detail/CVE-2023-0465){: external}
- [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}

### 1.6.4_3898_iks, released 24 March 2023
{: #1.6.4_3898_iks}

- Updates `golang` version to `1.20.2`.
- [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}
- [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}
- [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}
- [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}
- [CVE-2023-27537](https://nvd.nist.gov/vuln/detail/CVE-2023-27537){: external}
- [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}

### 1.6.4_3864_iks, released 13 March 2023
{: #1.6.4_3864_iks}

- Initial release of `1.6.4`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.6.4){: external}.
- Updates the default OpenSSL version from `1.1.1t` to `3.0.8`. 

TLS 1.0 and TLS 1.1 are no longer supported. Upgrade to the newer TLS version, or as a workaround you can change the security level to `0` for OpenSSL, by appending `@SECLEVEL=0` to your cipher list in the `kube-system/ibm-k8s-controller-config` ConfigMap. For example: `ssl-ciphers: HIGH:!aNULL:!MD5:!CAMELLIA:!AESCCM:!ECDH+CHACHA20@SECLEVEL=0`
{: important}



## Archive
{: #archive-unsupported}


### Version 1.8.1 (unsupported)
{: #1_8_1}

Version 1.8.1 is no longer supported.


#### 1.8.1_5543_iks, released 17 October 2023
{: #1.8.1_5543_iks}


- [CVE-2023-39325](https://nvd.nist.gov/vuln/detail/CVE-2023-39325){: external}
- [CVE-2023-38545](https://nvd.nist.gov/vuln/detail/CVE-2023-38545){: external}
- [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}
- [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}



#### 1.8.1_5434_iks, released 11 October 2023
{: #1.8.1_5434_iks}

- Go version update.


#### 1.8.1_5384_iks, released 5 October 2023
{: #1.8.1_5384_iks}

- [CVE-2023-38039](https://nvd.nist.gov/vuln/detail/CVE-2023-38039){: external}
- [CVE-2023-39318](https://nvd.nist.gov/vuln/detail/CVE-2023-39318){: external}
- [CVE-2023-39319](https://nvd.nist.gov/vuln/detail/CVE-2023-39319){: external}


#### 1.8.1_5317_iks, released 31 August 2023
{: #1.8.1_5317_iks}

- Initial release of `1.8.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.8.1){: external}.



### Version 1.5.1 (unsupported)
{: #1_5_1}

Version 1.5.1 is no longer supported.

#### 1.5.1_5542_iks, released 17 October 2023
{: #1.5.1_5542_iks}


- [CVE-2023-39325](https://nvd.nist.gov/vuln/detail/CVE-2023-39325){: external}
- [CVE-2023-38545](https://nvd.nist.gov/vuln/detail/CVE-2023-38545){: external}
- [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}


#### 1.5.1_5436_iks, released 11 October 2023
{: #1.5.1_5436_iks}

Go version update.

#### 1.5.1_5407_iks, released 5 October 2023
{: #1.5.1_5407_iks}

- [CVE-2023-38039](https://nvd.nist.gov/vuln/detail/CVE-2023-38039){: external}
- [CVE-2023-39318](https://nvd.nist.gov/vuln/detail/CVE-2023-39318){: external}
- [CVE-2023-39319](https://nvd.nist.gov/vuln/detail/CVE-2023-39319){: external}

#### 1.5.1_5318_iks, released 31 August 2023
{: #1.5.1_5318_iks}

- Resolves [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}
- Updates `golang` version to `1.20.7`.

#### 1.5.1_5217_iks, released 26 July 2023
{: #1.5.1_5217_iks}

- [CVE-2023-35945](https://nvd.nist.gov/vuln/detail/CVE-2023-35945){: external}
- [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}

#### 1.5.1_5160_iks, released 5 July 2023
{: #1.5.1_5160_iks}

- Resolves [CVE-2023-32731](https://nvd.nist.gov/vuln/detail/CVE-2023-32731){: external}

#### 1.5.1_5074_iks, released 6 June 2023
{: #1.5.1_5074_iks}

- Updates `golang` version to `1.20.4`.
- [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}
- [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}

#### 1.5.1_4168_iks, released 23 May 2023
{: #1.5.1_4168_iks}

- [CVE-2023-28319](https://nvd.nist.gov/vuln/detail/CVE-2023-28319){: external}
- [CVE-2023-28320](https://nvd.nist.gov/vuln/detail/CVE-2023-28320){: external}
- [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}
- [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}

#### 1.5.1_4113_iks, released 4 May 2023
{: #1.5.1_4113_iks}

- Image update.

#### 1.5.1_4064_iks, released 27 April 2023
{: #1.5.1_4064_iks}

- [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}
- [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}
- [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}
- [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}
- [CVE-2023-27537](https://nvd.nist.gov/vuln/detail/CVE-2023-27537){: external}
- [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}

#### 1.5.1_3977_iks, released 12 April 2023
{: #1.5.1_3977_iks}

Updates `golang` to version `1.20.3`.

#### 1.5.1_3951_iks, released 4 April 2023
{: #1.5.1_3951_iks}

- [CVE-2023-25809](https://nvd.nist.gov/vuln/detail/CVE-2023-25809){: external}
- [CVE-2023-28642](https://nvd.nist.gov/vuln/detail/CVE-2023-28642){: external}
- [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}
- [CVE-2023-0465](https://nvd.nist.gov/vuln/detail/CVE-2023-0465){: external}

#### 1.5.1_3897_iks, released 24 March 2023
{: #1.5.1_3897_iks}

Updates `golang` version to `1.20.2`.

#### 1.5.1_3863_iks, released 13 March 2023
{: #1.5.1_3863_iks}

Dependency updates.

#### 1.5.1_3809_iks, released 23 February 2023
{: #1.5.1_3809_iks}

- Updates `golang` version to 1.20.1.
- Resolves [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}

#### 1.5.1_3779_iks, released 20 February 2023
{: #1.5.1_3779_iks}

- [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}
- [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}
- [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}
- [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}
- [CVE-2023-23914](https://nvd.nist.gov/vuln/detail/CVE-2023-23914){: external}
- [CVE-2023-23915](https://nvd.nist.gov/vuln/detail/CVE-2023-23915){: external}
- [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}

#### 1.5.1_3705_iks, released 30 January 2023
{: #1.5.1_3705_iks}

Updates the golang version to 1.19.5.

#### 1.5.1_3683_iks, released 24 January 2023
{: #1.5.1_3683_iks}

Introduces support for multiple platform architectures such as AMD64 and s390x.

#### 1.5.1_3536_iks, released 3 January 2023
{: #1.5.1_3536_iks}

Initial release of `1.5.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.5.1){: external}.

### Version 1.4.0 (unsupported)
{: #1_4_0}

Version 1.4.0 is no longer supported.

#### 1.4.0_5218_iks, released 26 July 2023
{: #1.4.0_5218_iks}

- [CVE-2023-35945](https://nvd.nist.gov/vuln/detail/CVE-2023-35945){: external}
- [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}

#### 1.4.0_5159_iks, released 5 July 2023
{: #1.4.0_5159_iks}

- Resolves [CVE-2023-32731](https://nvd.nist.gov/vuln/detail/CVE-2023-32731){: external}

#### 1.4.0_5068_iks, released 6 June 2023
{: #1.4.0_5068_iks}

- Updates `golang` version to `1.20.4`.
- [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}
- [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}

#### 1.4.0_4169_iks, released 23 May 2023
{: #1.4.0_4169_iks}

- [CVE-2023-28319](https://nvd.nist.gov/vuln/detail/CVE-2023-28319){: external}
- [CVE-2023-28320](https://nvd.nist.gov/vuln/detail/CVE-2023-28320){: external}
- [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}
- [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}

#### 1.4.0_4114_iks, released 4 May 2023
{: #1.4.0_4114_iks}

- Image update.

#### 1.4.0_4062_iks, released 27 April 2023
{: #1.4.0_4062_iks}

- [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}
- [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}
- [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}
- [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}
- [CVE-2023-27537](https://nvd.nist.gov/vuln/detail/CVE-2023-27537){: external}
- [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}

#### 1.4.0_3978_iks, released 12 April 2023
{: #1.4.0_3978_iks}

Updates `golang` to version `1.20.3`.


#### 1.4.0_3953_iks, released 4 April 2023
{: #1.4.0_3953_iks}

- [CVE-2023-25809](https://nvd.nist.gov/vuln/detail/CVE-2023-25809){: external}
- [CVE-2023-28642](https://nvd.nist.gov/vuln/detail/CVE-2023-28642){: external}
- [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}
- [CVE-2023-0465](https://nvd.nist.gov/vuln/detail/CVE-2023-0465){: external}

#### 1.4.0_3896_iks, released 24 March 2023
{: #1.4.0_3896_iks}

Updates `golang` version to `1.20.2`.

#### 1.4.0_3862_iks, released 13 March 2023
{: #1.4.0_3862_iks}

Dependency updates.

#### 1.4.0_3808_iks, released 23 February 2023
{: #1.4.0_3808_iks}

- Updates `golang` version to 1.20.1.
- Resolves [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}

#### 1.4.0_3783_iks, released 20 February 2023
{: #1.4.0_3783_iks}

- [CVE-2023-23914](https://nvd.nist.gov/vuln/detail/CVE-2023-23914){: external}
- [CVE-2023-23915](https://nvd.nist.gov/vuln/detail/CVE-2023-23915){: external}
- [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}

#### 1.4.0_3755_iks, released 10 February 2023
{: #1.4.0_3755_iks}

- [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}
- [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}
- [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}
- [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}

#### 1.4.0_3703_iks, released 30 January 2023
{: #1.4.0_3703_iks}

Updates the golang version to 1.19.5.

#### 1.4.0_3684_iks, released 24 January 2023
{: #1.4.0_3684_iks}

Introduces support for multiple platform architectures such as AMD64 and s390x.

#### 1.4.0_3537_iks, released 3 January 2023
{: #1.4.0_3537_iks}

- [CVE-2022-43551](https://nvd.nist.gov/vuln/detail/CVE-2022-43551){: external}
- [CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external}

#### 1.4.0_3297_iks, released 15 December 2022
{: #1.4.0_3297_iks}

[CVE-2022-41717](https://www.cve.org/CVERecord?id=CVE-2022-41717){: external}

#### 1.4.0_3212_iks, released 12 December 2022
{: #1.4.0_3212_iks}

Initial release of `1.4.0`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.4.0){: external}.

### Version 1.3.1 (unsupported)
{: #1_3_1}

Version 1.3.1 is no longer supported.

#### 1.3.1_3807_iks, released 23 February 2023
{: #1.3.1_3807_ikss}

- Updates `golang` version to 1.20.1.
- Resolves [CVE-2022-41723](https://nvd.nist.gov/vuln/detail/CVE-2022-41723){: external}

#### 1.3.1_3777_iks, released 20 February 2023
{: #1.3.1_3777_iks}

- [CVE-2023-23914](https://nvd.nist.gov/vuln/detail/CVE-2023-23914){: external}
- [CVE-2023-23915](https://nvd.nist.gov/vuln/detail/CVE-2023-23915){: external}
- [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}

#### 1.3.1_3754_iks, released 10 February 2023
{: #1.3.1_3754_iks}

- [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}
- [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}
- [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}
- [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}

#### 1.3.1_3704_iks, released 30 January 2023
{: #1.3.1_3704_iks}

Updates the golang version to 1.19.5.

#### 1.3.1_3685_iks, released 24 January 2023
{: #1.3.1_3685_iks}

Introduces support for multiple platform architectures such as AMD64 and s390x.

#### 1.3.1_3538_iks, released 3 January 2023
{: #1.3.1_3538_iks}

- [CVE-2022-43551](https://nvd.nist.gov/vuln/detail/CVE-2022-43551){: external}
- [CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external}

#### 1.3.1_3298_iks, released 15 December 2022
{: #1.3.1_3298_iks}

[CVE-2022-41717](https://www.cve.org/CVERecord?id=CVE-2022-41717){: external}

#### 1.3.1_3192_iks, released 8 December 2022
{: #1.3.1_3192_iks}

Updated the golang version to 1.19.3.

#### 1.3.1_3108_iks, released 30 November 2022
{: #1.3.1_3108_iks}

Initial release of `1.3.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.3.1){: external}.


### Version 1.3.0 (unsupported)
{: #1_3_0}

Version 1.3.0 is no longer supported.

#### 1.3.0_2907_iks, released 31 October 2022
{: #1.3.0_2907_iks}

- [CVE-2022-32221](https://www.cve.org/CVERecord?id=CVE-2022-32221){: external}
- [CVE-2022-42915](https://www.cve.org/CVERecord?id=CVE-2022-42915){: external}
- [CVE-2022-42916](https://www.cve.org/CVERecord?id=CVE-2022-42916){: external} 

#### 1.3.0_2847_iks, released 25 October 2022
{: #1.3.0_2847_iks}

Initial release of `1.3.0`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.3.0){: external}.

### Version 1.2.1 (unsupported)
{: #1_2_1}

Version 1.2.1 is no longer supported.

#### 1.2.1_3299_iks, released 15 December 2022
{: #1.2.1_3299_iks}

[CVE-2022-41717](https://www.cve.org/CVERecord?id=CVE-2022-41717){: external}

#### 1.2.1_3186_iks, released 5 December 2022
{: #1.2.1_3186_iks}

Updated the golang version to 1.19.3.

#### 1.2.1_3111_iks, released 30 November 2022
{: #1.2.1_3111_iks}

Metadata changes.

#### 1.2.1_2809_iks, released 25 October 2022
{: #1.2.1_2809_iks}

- [CVE-2022-32149](https://www.cve.org/CVERecord?id=CVE-2022-32149){: external}
- [CVE-2022-40303](https://www.cve.org/CVERecord?id=CVE-2022-40303){: external}
- [CVE-2022-40304](https://www.cve.org/CVERecord?id=CVE-2022-40304){: external} 

#### 1.2.1_2714_iks, released 13 October 2022
{: #1.2.1_2714_iks}

Updated the NGINX base image.

#### Version 1.2.1_2646_iks, released 3 October 2022
{: #1.2.1_2646_iks}

- Managed configuration changes. For more information, see [Ingress ConfigMap change log](/docs/containers?topic=containers-ibm-k8s-controller-config-change-log).

#### Version 1.2.1_2558_iks, released 21 September 2022
{: #1.2.1_2558_iks}

- [CVE-2022-35252](https://www.cve.org/CVERecord?id=CVE-2022-35252){: external}
- [CVE-2022-27664](https://www.cve.org/CVERecord?id=CVE-2022-27664){: external}

#### Version 1.2.1_2506_iks, released 25 August 2022
{: #1.2.1_2506_iks}

- [CVE-2022-3209](https://www.cve.org/CVERecord?id=CVE-2022-3209){: external}

#### Version 1.2.1_2488_iks, released 11 August 2022
{: #1.2.1_2488_iks}

- [CVE-2022-37434](https://www.cve.org/CVERecord?id=CVE-2022-37434){: external}

#### Version 1.2.1_2487_iks, released 11 August 2022
{: #1.2.1_2487_iks}

- [CVE-2022-37434](https://www.cve.org/CVERecord?id=CVE-2022-37434){: external}

#### Version 1.2.1_2426_iks, released 2 August 2022
{: #1.2.1_2426_iks}

- [CVE-2022-30065](https://www.cve.org/CVERecord?id=CVE-2022-30065){: external}
- [CVE-2022-21221](https://www.cve.org/CVERecord?id=CVE-2022-21221){: external}



#### Version 1.2.1_2415_iks, released 19 July 2022
{: #1.2.1_2415_iks}

- [CVE-2022-29458](https://www.cve.org/CVERecord?id=CVE-2022-29458){: external}
- [CVE-2022-2097](https://www.cve.org/CVERecord?id=CVE-2022-2097){: external}
- [CVE-2022-27781](https://www.cve.org/CVERecord?id=CVE-2022-27781){: external}
- [CVE-2022-27782](https://www.cve.org/CVERecord?id=CVE-2022-27782){: external}
- [CVE-2022-32205](https://www.cve.org/CVERecord?id=CVE-2022-32205){: external}
- [CVE-2022-32206](https://www.cve.org/CVERecord?id=CVE-2022-32206){: external}
- [CVE-2022-32207](https://www.cve.org/CVERecord?id=CVE-2022-32207){: external}
- [CVE-2022-32208](https://www.cve.org/CVERecord?id=CVE-2022-32208){: external} 

#### Version 1.2.1_2337_iks, released 10 Jun 2022
{: #1.2.1_2337_iks}

- Initial release of `1.2.1`. For more information, see the [community release documentation](https://github.com/kubernetes/ingress-nginx/releases/tag/controller-v1.2.1){: external}.
- Resolves [CVE-2021-25748](https://www.cve.org/CVERecord?id=CVE-2021-25748){: external}

### Version 1.2.0 (unsupported)
{: #1_2_0}

#### Version 1.2.0_2251_iks, released 19 May 2022
{: #1.2.0_2251_iks}

Resolves [CVE-2022-29824](https://www.cve.org/CVERecord?id=CVE-2022-29824){: external}

#### Version 1.2.0_2147_iks, released 4 May 2022
{: #1.2.0_2147_iks}

- [CVE-2022-22576](https://www.cve.org/CVERecord?id=CVE-2022-22576){: external}
- [CVE-2022-27774](https://www.cve.org/CVERecord?id=CVE-2022-27774){: external}
- [CVE-2022-27775](https://www.cve.org/CVERecord?id=CVE-2022-27775){: external}
- [CVE-2022-27776](https://www.cve.org/CVERecord?id=CVE-2022-27776){: external}
- [CVE-2022-28327](https://www.cve.org/CVERecord?id=CVE-2022-28327){: external}
- [CVE-2022-24675](https://www.cve.org/CVERecord?id=CVE-2022-24675){: external}
- [CVE-2022-27536](https://www.cve.org/CVERecord?id=CVE-2022-27536){: external}
