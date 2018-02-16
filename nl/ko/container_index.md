---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-13"

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

Kubernetes 클러스터에서 실행되는 Docker 컨테이너에 고가용성 앱을 배치하여 {{site.data.keyword.Bluemix_notm}}를 진행하십시오. 컨테이너는 환경 간에 앱을 원활하게 이동시킬 수 있도록 앱 및 해당 종속성을 모두 패키징하는 표준 방식입니다.  가상 머신과 달리 컨테이너는 운영 체제를 함께 제공하지 않습니다. 앱 코드, 런타임, 시스템 도구, 라이브러리 및 설정만 컨테이너 내에 패키징됩니다. 컨테이너는 가상 머신보다 경량이고 휴대하기 쉬우며 효율적입니다.
{:shortdesc}


시작하려면 옵션을 클릭하십시오.

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="{{site.data.keyword.containershort_notm}}를 빠르게 시작하려면 아이콘을 클릭하십시오. {{site.data.keyword.Bluemix_dedicated_notm}}에서 이 아이콘을 클릭하면 옵션이 표시됩니다. " style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="{{site.data.keyword.Bluemix_notm}}에서 Kubernetes 클러스터 시작하기" title="{{site.data.keyword.Bluemix_notm}}에서 Kubernetes 클러스터 시작하기" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="CLI를 설치하십시오." title="CLI를 설치하십시오." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} 클라우드 환경" title="{{site.data.keyword.Bluemix_notm}} 클라우드 환경" shape="rect" coords="326, -10, 448, 218" />
</map>


## 클러스터 시작하기
{: #clusters}

컨테이너에 앱을 배치하시겠습니까? 기다리십시오. 먼저 Kubernetes 클러스터 작성으로 시작하십시오. Kubernetes는 컨테이너를 위한 오케스트레이션 도구입니다. Kubernetes를 사용하면 개발자는 클러스터의 처리 능력과 유연성을 사용하여 고가용성 앱을 신속하게 배치할 수 있습니다.
{:shortdesc}

클러스터는 무엇입니까? 클러스터는 앱의 고가용성을 유지시키는 리소스, 작업자 노드, 네트워크 및 스토리지 디바이스의 세트입니다. 클러스터가 있으면 컨테이너에 앱을 배치할 수 있습니다.

[라이트 클러스터를 작성하려면 시작하기 전에 종량과금제 또는 구독 {{site.data.keyword.Bluemix_notm}} 계정이 있어야 합니다. ](https://console.bluemix.net/registration/)


라이트 클러스터를 작성하려면 다음을 수행하십시오.

1.  [**카탈로그** ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/catalog/?category=containers)의 **컨테이너** 카테고리에서 **Kubernetes 클러스터**를 클릭하십시오.

2.  **클러스터 이름**을 입력하십시오. 기본 클러스터 유형은 라이트입니다. 다음 번에는 표준 클러스터를 작성하고 추가로 사용자 정의(예: 클러스터에 있는 작업자 노드의 수)를 정의할 수 있습니다.

3.  **클러스터 작성**을 클릭하십시오. 클러스터에 대한 세부사항이 열리지만 클러스터에서 작업자 노드를 프로비저닝하려면 몇 분이 소요됩니다. **작업자 노드** 탭에서 작업자 노드의 상태를 볼 수 있습니다. 상태가 `Ready`가 되면 작업자 노드를 사용할 준비가 된 것입니다.

잘하셨습니다! 첫 번째 클러스터를 작성했습니다!

*   라이트 클러스터에는 앱이 사용할 수 있는 2개의 CPU와 4GB의 메모리가 있는 하나의 작업자 노드가 있습니다.
*   클러스터에서 모든 Kubernetes 리소스를 제어하고 모니터링하는 전용 및 고가용성의 {{site.data.keyword.IBM_notm}} 소유 Kubernetes 마스터가 작업자 노드를 중앙에서 모니터링하고 관리합니다. 사용자는 이 마스터를 관리하기 위해 염려할 필요가 없으며 작업자 노드에 배치된 작업자 노드 및 앱에만 집중할 수 있습니다.
*   VLAN 및 IP 주소와 같은 클러스터를 실행하는 데 필요한 리소스는 {{site.data.keyword.IBM_notm}} 소유 IBM Cloud 인프라(SoftLayer) 계정에서 관리됩니다. 표준 클러스터를 작성할 때 고유의 IBM Cloud 인프라(SoftLayer) 계정에서 이러한 리소스를 관리합니다. 표준 클러스터를 작성할 때 이러한 리소스에 대하여 더 자세히 알 수 있습니다.


**다음 단계: **

클러스터가 시작되어 실행 중이면 클러스터에 대한 작업을 시작하십시오.

* [클러스터 관련 작업을 시작하도록 CLI 설치.](cs_cli_install.html#cs_cli_install)
* [클러스터에 앱을 배치하십시오. ](cs_app.html#app_cli)
* [더 높은 가용성을 위해 여러 노드가 있는 표준 클러스터 작성.](cs_clusters.html#clusters_ui)
* [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정하십시오.](/docs/services/Registry/index.html)
