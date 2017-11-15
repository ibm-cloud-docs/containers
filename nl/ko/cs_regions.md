---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-18"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 지역 및 위치
{{site.data.keyword.Bluemix}}는 전세계적으로 호스팅됩니다. 지역은 엔드포인트에서 액세스하는 지리적 영역입니다.
위치는 지역 내의 데이터 센터입니다. {{site.data.keyword.Bluemix_notm}} 내의 서비스는 글로벌로 사용 가능하거나 특정 지역 내에서 사용 가능할 수 있습니다.
{:shortdesc}

[{{site.data.keyword.Bluemix_notm}} 지역](#bluemix_regions)은 [{{site.data.keyword.containershort_notm}} 지역](#container_regions)과 다릅니다.

지원되는 {{site.data.keyword.containershort_notm}} 지역:
  * AP 남부
  * 중앙 유럽
  * 영국 남부
  * 미국 동부
  * 미국 남부

## {{site.data.keyword.Bluemix_notm}} 지역 API 엔드포인트
{: #bluemix_regions}

{{site.data.keyword.Bluemix_notm}} 지역을 사용하여 {{site.data.keyword.Bluemix_notm}} 서비스에 걸쳐 리소스를 구성할 수 있습니다. 예를 들어, 동일한 지역의 {{site.data.keyword.registryshort_notm}}에 저장된 개인용 Docker 이미지를 사용하여 Kubernetes 클러스터를 작성할 수 있습니다.
{:shortdesc}

현재 사용자가 속해 있는 {{site.data.keyword.Bluemix_notm}} 지역을 확인하려면 `bx info`를 실행하고 **지역** 필드를 검토하십시오.

로그인할 때 API 엔드포인트를 지정하여 {{site.data.keyword.Bluemix_notm}} 지역에 액세스할 수 있습니다. 지역을 지정하지 않으면 가장 근접한 지역에 자동으로 로그인됩니다.

예제 로그인 명령을 사용하는 {{site.data.keyword.Bluemix_notm}} 지역 API 엔드포인트:

  * 미국 남부 및 미국 동부
      ```
           bx login -a api.ng.bluemix.net
           ```
      {: pre}

  * 시드니
      ```
        bx login -a api.au-syd.bluemix.net
        ```
      {: pre}

  * 독일
      ```
           bx login -a api.eu-de.bluemix.net
           ```
      {: pre}

  * 영국
      ```
           bx login -a api.eu-gb.bluemix.net
           ```
      {: pre}



<br />


## {{site.data.keyword.containershort_notm}} 지역 API 엔드포인트 및 위치
{: #container_regions}

{{site.data.keyword.containershort_notm}} 지역을 사용하여 사용자가 로그인한 {{site.data.keyword.Bluemix_notm}} 지역 이외의 지역에 Kubernetes 클러스터를 작성하거나 액세스할 수 있습니다. {{site.data.keyword.containershort_notm}} 지역 엔드포인트는 특별히 {{site.data.keyword.Bluemix_notm}}가 아니라 {{site.data.keyword.containershort_notm}}를 전체적으로 참조합니다.
{:shortdesc}

{{site.data.keyword.containershort_notm}} 지역 API 엔드포인트:
  * AP 남부: `https://ap-south.containers.bluemix.net`
  * 중앙 유럽: `https://eu-central.containers.bluemix.net`
  * 영국 남부: `https://uk-south.containers.bluemix.net`
  * 미국 동부: `https://us-east.containers.bluemix.net`
  * 미국 남부: `https://us-south.containers.bluemix.net`

**참고:** 미국 동부는 CLI 명령으로만 사용할 수 있습니다.

현재 사용자가 속해 있는 {{site.data.keyword.containershort_notm}} 지역을 확인하려면 `bx cs api`를 실행하고 **지역** 필드를 검토하십시오.

### 다른 컨테이너 서비스 지역에 로그인
{: #container_login_endpoints}

다음과 같은 이유로 다른 {{site.data.keyword.containershort_notm}} 지역에 로그인할 수 있습니다.
  * 한 지역에 {{site.data.keyword.Bluemix_notm}} 서비스 또는 사설 Docker를 작성한 후 다른 지역의 {{site.data.keyword.containershort_notm}}에서 사용하려고 합니다.
  * 사용자가 로그인한 기본 {{site.data.keyword.Bluemix_notm}} 지역과 다른 지역에 있는 클러스터에 액세스하려고 합니다.

</br>

{{site.data.keyword.containershort_notm}} 지역에 로그인하기 위한 예제 명령:
  * AP 남부:
    ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
    {: pre}

  * 중앙 유럽:
    ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
    {: pre}

  * 영국 남부:
    ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
    {: pre}

  * 미국 동부:
    ```
    bx cs init --host https://us-east.containers.bluemix.net
    ```
    {: pre}

  * 미국 남부:
    ```
         bx cs init --host https://us-south.containers.bluemix.net
        ```
    {: pre}

### 컨테이너 서비스 지역에 라이트 클러스터 작성
{: #lite_regions}

다음 지역에 Kubernetes 라이트 클러스터를 작성할 수 있습니다.
  * AP 남부
  * 중앙 유럽
  * 영국 남부
  * 미국 남부

### 컨테이너 서비스에 사용 가능한 위치
{: #locations}

위치는 지역 내에서 사용 가능한 데이터 센터입니다.

  | 지역| 위치| 구/군/시|
  |--------|----------|------|
  | AP 남부      | mel01, syd01, syd04        | 멜버른, 시드니 |
  | 중앙 유럽    | ams03, fra02        | 암스테르담, 프랑크푸르트|
  | 영국 남부    | lon02, lon04        | 런던|
  | 미국 동부    | wdc06, wdc07        | 워싱턴, DC |
  | 미국 남부| dal10, dal12, dal13       | Dallas
|

### 컨테이너 서비스 API 명령 사용
{: #container_api}

{{site.data.keyword.containershort_notm}} API와 상호작용하려면 명령 유형을 입력하고 `/v1/command`를 엔드포인트에 추가하십시오.

미국 남부의 `GET /clusters` API 예제:
  ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
  {: codeblock}

</br>

API 명령에 대한 문서를 보려면 보려는 지역의 엔드포인트에 `swagger-api`를 추가하십시오.
  * AP 남부: https://ap-south.containers.bluemix.net/swagger-api/
  * 중앙 유럽: https://eu-central.containers.bluemix.net/swagger-api/
  * 영국 남부: https://uk-south.containers.bluemix.net/swagger-api/
  * 미국 동부: https://us-east.containers.bluemix.net/swagger-api/
  * 미국 남부: https://us-south.containers.bluemix.net/swagger-api/
