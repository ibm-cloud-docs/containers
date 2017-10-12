---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-014"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# {{site.data.keyword.containerlong_notm}} 시작하기
{: #container_index}

{{site.data.keyword.IBM}} 클라우드에서 Kubernetes 클러스터 및 Docker 컨테이너 내부의 고가용성 앱을 관리합니다. 컨테이너는 환경 간에 앱을 이동하고 변경사항 없이 앱을 실행할 수 있도록 앱과 모든 종속 항목을 패키징하는 표준 방법입니다.  가상 머신과 달리 컨테이너는 운영 체제를 함께 제공하지 않습니다.
앱 코드, 런타임, 시스템 도구, 라이브러리 및 설정만 컨테이너 내부에 패키징되며 이를 통해 컨테이너가 가상 머신보다 경량으로 유지되어
이식성이 높아지고 효율적이게 됩니다. 

시작하려면 옵션을 클릭하십시오. 

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Bluemix 퍼블릭에서는 Kubernetes 클러스터를 작성하거나 단일 및 확장 가능 컨테이너 그룹을 클러스터에 마이그레이션할 수 있습니다. Bluemix 데디케이티드에서는 이 아이콘을 클릭하여 옵션을 확인하십시오." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Bluemix에서 Kubernetes 클러스터 시작하기" title="Bluemix에서 Kubernetes 클러스터 시작하기" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_classic.html#cs_classic" alt="IBM Bluemix Container Service(Kraken)에서 단일 및 확장 가능 컨테이너 실행" title="IBM Bluemix Container Service(Kraken)에서 단일 및 확장 가능 컨테이너 실행" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_ov.html#dedicated_environment" alt="Bluemix 데디케이티드 클라우드 환경" title="Bluemix 데디케이티드 클라우드 환경" shape="rect" coords="326, -10, 448, 218" />
</map>


## {{site.data.keyword.Bluemix_notm}}에서 클러스터 시작하기
{: #clusters}

Kubernetes는 컴퓨팅 시스템의 클러스터 상에서 앱 컨테이너를 스케줄링하기 위한 오케스트레이션 도구입니다. Kubernetes를 통해 개발자는 컨테이너의 처리능력과 유연성을 사용하여 고가용성 애플리케이션을 신속하게 개발할 수 있습니다. {:shortdesc}

Kubernetes를 사용하여 앱을 배치하려면 우선 클러스터 작성부터 시작하십시오. 클러스터는 네트워크로 구성된 작업자 노드의 세트입니다. 클러스터의 용도는
애플리케이션의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 

라이트 클러스터를 작성하려면 다음을 수행하십시오. 

1.  [**카탈로그** ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/catalog/?category=containers)의 **컨테이너** 카테고리에서 **Kubernetes 클러스터**를 클릭하십시오.

2.  클러스터 세부사항을 입력하십시오. 기본 클러스터 유형이 라이트이기 때문에 일부 필드만 사용자 정의할 수 있습니다. 다음 번에는 표준 클러스터를 작성하고 추가로 사용자 정의(예: 클러스터에 있는 작업자 노드의 수)를 정의할 수 있습니다. 
    1.  **클러스터 이름**을 입력하십시오. 
    2.  클러스터가 배치될 **위치**를 선택하십시오. 사용 가능한 위치는 사용자가 로그인한 지역에 따라 다릅니다. 
최고의 성능을 위해서는 실제로 사용자와 가장 가까운 지역을 선택하십시오.


    사용 가능한 위치는 다음과 같습니다. 

    <ul><li>미국 남부<ul><li>dal10 [댈러스]</li><li>dal12 [댈러스]</li></ul></li><li>영국 남부<ul><li>lon02 [런던]</li><li>lon04 [런던]</li></ul></li><li>중앙 유럽<ul><li>ams03 [암스테르담]</li><li>ra02 [프랑크푸르트]</li></ul></li><li>AP 남부<ul><li>syd01 [시드니]</li><li>syd04 [시드니]</li></ul></li></ul>
        
3.  **클러스터 작성**을 클릭하십시오.클러스터에 대한 세부사항이 열리지만 클러스터에서 작업자 노드를 프로비저닝하려면 몇 분이 소요됩니다. **작업자 노드** 탭에서 작업자 노드의 상태를 볼 수 있습니다. 상태가 `Ready`가 되면 작업자 노드를 사용할 준비가 된 것입니다. 

잘하셨습니다! 첫 번째 클러스터를 작성했습니다! 

*   라이트 클러스터에는 앱이 사용할 수 있는 2개의 CPU와 4GB의 메모리가 있는 하나의 작업자 노드가 있습니다. 
*   클러스터에서 모든 Kubernetes 리소스를 제어하고 모니터링하는 전용 및 고가용성의 {{site.data.keyword.IBM_notm}} 소유 Kubernetes 마스터가 작업자 노드를 중앙에서 모니터링하고 관리합니다. 사용자는 이 마스터를 관리하기 위해 염려할 필요가 없으며 작업자 노드에 배치된 작업자 노드 및 앱에만 집중할 수 있습니다. 
*   VLAN 및 IP 주소와 같은 클러스터를 실행하는 데 필요한 리소스는 {{site.data.keyword.IBM_notm}} 소유 {{site.data.keyword.BluSoftlayer_full}} 계정에서 관리됩니다. 표준 클러스터를 작성할 때 사용자 고유의 {{site.data.keyword.BluSoftlayer_notm}}
계정에서 이러한 리소스를 관리합니다. 표준 클러스터를 작성할 때 이러한 리소스에 대하여 더 자세히 알 수 있습니다. 
*   **팁:** [{{site.data.keyword.Bluemix_notm}} 종량과금제로 업그레이드](/docs/pricing/billable.html#upgradetopayg)하지 않는 한 {{site.data.keyword.Bluemix_notm}} 무료 평가판 계정으로 작성된 라이트 클러스터는 무료 평가판 기간이 종료되면 자동으로 제거됩니다.


**다음 단계: **

클러스터가 시작되어 실행 중인 경우에는 다음 태스크를 수행할 수 있습니다. 

* [클러스터 관련 작업을 시작하도록 CLI 설치.](cs_cli_install.html#cs_cli_install)
* [클러스터에 앱을 배치하십시오. ](cs_apps.html#cs_apps_cli)
* [더 높은 가용성을 위해 여러 노드가 있는 표준 클러스터 작성.](cs_cluster.html#cs_cluster_ui)
* [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정하십시오.](/docs/services/Registry/index.html)


## {{site.data.keyword.Bluemix_notm}} 데디케이티드(비공개 베타)에서 클러스터 시작하기
{: #dedicated}

Kubernetes는 컴퓨팅 시스템의 클러스터 상에서 앱 컨테이너를 스케줄링하기 위한 오케스트레이션 도구입니다. Kubernetes를 사용하여 개발자는 자체 {{site.data.keyword.Bluemix_notm}} 데디케이티드 인스턴스에서 컨테이너의 처리 능력과 유연성을 최대한 사용하여 고가용성 애플리케이션을 신속하게 개발할 수 있습니다.
{:shortdesc}

시작하기 전에 [{{site.data.keyword.Bluemix_notm}} 데디케이티드 환경을 설정](cs_ov.html#setup_dedicated)하십시오. 그 다음에 클러스터를 작성할 수 있습니다. 클러스터는 네트워크로 구성된 작업자 노드의 세트입니다. 클러스터의 용도는 애플리케이션의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 클러스터를 보유하게 되면 앱을 클러스터에 배치할 수 있습니다. 

**팁:** 사용자 조직에 아직 {{site.data.keyword.Bluemix_notm}} 데디케이티드 환경이 없는 경우, 이는 필요하지 않습니다. [우선 {{site.data.keyword.Bluemix_notm}} 퍼블릭 환경에서 데디케이티드, 표준 클러스터를 시도하십시오. ](cs_cluster.html#cs_cluster_ui)

{{site.data.keyword.Bluemix_notm}} 데디케이티드에 클러스터를 배치하려면 다음을 수행하십시오. 

1.  IBM ID로 {{site.data.keyword.Bluemix_notm}} 퍼블릭 콘솔([https://console.bluemix.net ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/catalog/?category=containers))에 로그인하십시오. {{site.data.keyword.Bluemix_notm}} 퍼블릭에서 클러스터를 요청해야 하지만 {{site.data.keyword.Bluemix_notm}} 데디케이티드 계정으로 배치합니다. 
2.  계정이 여러 개이면 계정 메뉴에서 {{site.data.keyword.Bluemix_notm}} 계정을 선택하십시오.
3.  카탈로그의 **컨테이너** 카테고리에서 **Kubernetes 클러스터**를 클릭하십시오.
4.  클러스터 세부사항을 입력하십시오.
    1.  **클러스터 이름**을 입력하십시오. 
    2.  작업자 노드에서 사용할 **Kubernetes 버전**을 선택하십시오.  
    3.  **시스템 유형**을 선택하십시오. 시스템 유형은 각 작업자 노드에서 설정되었으며 노드에 배치된 모든 컨테이너가 사용할 수 있는 가상 CPU 및 메모리의 양을 정의합니다. 
    4.  필요한 **작업자 노드의 수**를 선택하십시오. 클러스터의 고가용성을 위해 3을 선택하십시오. 
    
    클러스터 유형, 위치, 퍼블릭 VLAN, 프라이빗 VLAN 및 하드웨어 필드는 {{site.data.keyword.Bluemix_notm}} 데디케이티드 계정을 작성하는 과정 중에 정의되므로 사용자는 해당 값을 조정할 수 없습니다.
5.  **클러스터 작성**을 클릭하십시오. 클러스터에 대한 세부사항이 열리지만, 클러스터의 작업자 노드를 프로비저닝하는 데 수 분이 걸립니다. **작업자 노드** 탭에서 작업자 노드의 상태를 볼 수 있습니다. 상태가 `Ready`가 되면 작업자 노드를 사용할 준비가 된 것입니다. 

    클러스터에서 모든 Kubernetes 리소스를 제어하고 모니터링하는 전용 및 고가용성의 {{site.data.keyword.IBM_notm}} 소유 Kubernetes 마스터가 작업자 노드를 중앙에서 모니터링하고 관리합니다. 사용자는 작업자 노드 및 이 작업자 노드에 배치된 앱에만 집중할 수 있으며, 이 마스터의 관리에 대해서는 따로 신경쓰지 않아도 됩니다. 

잘하셨습니다! 첫 번째 클러스터를 작성했습니다! 


**다음 단계: **

클러스터가 시작되어 실행 중인 경우에는 다음 태스크를 수행할 수 있습니다. 

* [클러스터 관련 작업을 시작하도록 CLI 설치.](cs_cli_install.html#cs_cli_install)
* [클러스터에 앱 배치.](cs_apps.html#cs_apps_cli)
* [클러스터에 {{site.data.keyword.Bluemix_notm}} 서비스 추가.](cs_cluster.html#binding_dedicated)
* [{{site.data.keyword.Bluemix_notm}} 데디케이티드 및 퍼블릭의 클러스터 간 차이점에 대해 자세히 보기.](cs_ov.html#env_differences)

