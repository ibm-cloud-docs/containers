---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터 설정
{: #cs_cluster}

최대 가용성 및 용량을 위한 클러스터 설정을 설계합니다.
{:shortdesc}

다음 다이어그램에는 가용성이 증가하는 공통 클러스터 구성이 포함됩니다.

![클러스터의 고가용성 단계](images/cs_cluster_ha_roadmap.png)

다이어그램에 표시된 대로 다중 작업자 노드에 앱을 배치하면 앱의 가용성이 높아집니다. 다중 클러스터에 앱을 배치하면 가용성이 훨씬 높아집니다. 최고의 가용성을 위해서는 여러 지역의 클러스터에 앱을 배치하십시오. [세부사항은 고가용성 클러스터 구성을 위한 옵션을 검토하십시오.](cs_planning.html#cs_planning_cluster_config)

<br />


## GUI에서 클러스터 작성
{: #cs_cluster_ui}

Kubernetes 클러스터는 네트워크로 구성된 작업자 노드의 세트입니다. 클러스터의 용도는 애플리케이션의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 앱을 배치하려면 우선 클러스터를 작성하고 해당 클러스터에서 작업자 노드에 대한 정의를 설정해야 합니다.
{:shortdesc}

클러스터를 작성하려면 다음을 수행하십시오. 
1. 카탈로그에서 **Kubernetes 클러스터**를 선택하십시오.
2. 클러스터 플랜의 유형을 선택하십시오. **라이트** 또는 **종량과금제**를 선택할 수 있습니다. 종량과금제 플랜을 사용하면 고가용성 환경을 위한 다중 작업자 노드와 같은 기능이 있는 표준 클러스터를 프로비저닝할 수 있습니다.
3. 클러스터 세부사항을 구성하십시오.
    1. 클러스터 이름을 제공하고 Kubernetes 버전을 선택한 후 배치할 위치를 선택하십시오. 최고의 성능을 위해서는 실제로 사용자와 가장 가까운 위치를 선택하십시오. 사용자 국가 외부의 위치를 선택하는 경우에는 외국에서 데이터를 물리적으로 저장하기 전에 법적 인가를 받아야 할 수 있다는 점을 기억하십시오. 
    2. 시스템의 유형을 선택하고 필요한 작업자 노드의 수를 지정하십시오. 시스템 유형은 각 작업자 노드에서 설정되고 컨테이너에 사용 가능한 가상 CPU 및 메모리의 양을 정의합니다. 
        - 마이크로 머신 유형은 최소 옵션을 나타냅니다. 
        - 밸런스 머신에는 성능을 최적화하는 각 CPU에 지정된 것과 동일한 양의 메모리가 있습니다. 
        - 이름에 `encrypted`가 있는 시스템 유형은 호스트의 Docker 데이터를 암호화합니다. 모든 컨테이너 데이터가 저장된 `/var/lib/docker` 디렉토리는 LUKS 암호화를 통해 암호화됩니다.
    3. IBM Cloud 인프라(SoftLayer) 계정에서 퍼블릭 및 프라이빗 VLAN을 선택하십시오. 두 VLAN 모두 작업자 노드 간에 통신하지만 퍼블릭 VLAN은 IBM 관리 Kubernetes 마스터와도 통신합니다. 다중 클러스터에 대해 동일한 VLAN을 사용할 수 있습니다.
        **참고**: 퍼블릭 VLAN을 선택하지 않도록 결정한 경우에는 대체 솔루션을 구성해야 합니다.
    4. 하드웨어 유형을 선택하십시오. 대부분의 경우에는 공유 옵션으로도 충분합니다. 
        - **데디케이티드**: 실제 리소스의 완전한 격리를 보장합니다.
        - **공유**: 실제 리소스를 기타 IBM 고객과 동일한 하드웨어에 저장할 수 있습니다. 
        - 작업자 노드는 기본적으로 디스크 암호화 기능을 합니다. [자세히 보기](cs_security.html#cs_security_worker). 암호화를 사용하지 않으려면 **로컬 디스크 암호화** 선택란을 선택 취소하십시오. 
4. **클러스터 작성**을 클릭하십시오. **작업자 노드** 탭에서 작업자 노드 배치의 진행상태를 볼 수 있습니다. 배치가 완료되면 **개요** 탭에서 클러스터가 준비되었는지 확인할 수 있습니다.
    **참고:** 모든 작업자 노드에는 클러스터가 작성된 이후 수동으로 변경될 수 없는 고유 작업자 노드 ID 및 도메인 이름이 지정됩니다. 
ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 클러스터를 관리할 수 없습니다. 


**다음 단계: **

클러스터가 시작되어 실행 중인 경우에는 다음 태스크를 수행할 수 있습니다. 

-   [클러스터 관련 작업을 시작하도록 CLI를 설치합니다.](cs_cli_install.html#cs_cli_install)
-   [클러스터에 앱을 배치합니다. ](cs_apps.html#cs_apps_cli)
-   [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정합니다.](/docs/services/Registry/index.html)
- 방화벽이 있는 경우, 클러스터에서 아웃바운드 트래픽을 허용하거나 네트워킹 서비스를 위한 인바운드 트래픽을 허용하려면 `bx`, `kubectl` 또는 `calicotl` 명령을 사용하기 위해 [필수 포트를 열어야](cs_security.html#opening_ports) 할 수도 있습니다. 

<br />


## CLI에서 클러스터 작성
{: #cs_cluster_cli}

클러스터는 네트워크로 구성된 작업자 노드의 세트입니다. 클러스터의 용도는 애플리케이션의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 앱을 배치하려면 우선 클러스터를 작성하고 해당 클러스터에서 작업자 노드에 대한 정의를 설정해야 합니다.
{:shortdesc}

클러스터를 작성하려면 다음을 수행하십시오. 
1.  {{site.data.keyword.Bluemix_notm}} CLI 및 [{{site.data.keyword.containershort_notm}} 플러그인](cs_cli_install.html#cs_cli_install)을 설치하십시오.
2.  {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오.프롬프트가 표시되면 {{site.data.keyword.Bluemix_notm}} 신임 정보를 입력하십시오. 

    ```
        bx login
        ```
    {: pre}

    **참고:** 연합 ID가 있는 경우 `bx login --sso`를 사용하여 {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 사용자 이름을 입력하고 CLI 출력에서 제공된 URL을 사용하여 일회성 패스코드를 검색하십시오. `--sso` 옵션을 사용하지 않으면 로그인에 실패하고 `--sso` 옵션을 사용하면 성공하는 경우에는 연합 ID를 보유하고 있다는 것입니다. 

3. 여러 {{site.data.keyword.Bluemix_notm}} 계정이 있는 경우에는 Kubernetes 클러스터를 작성할 계정을 선택하십시오.

4.  이전에 선택한 {{site.data.keyword.Bluemix_notm}} 지역 이외의 지역에 Kubernetes 클러스터를 작성하거나 액세스하려면 `bx cs region-set`를 실행하십시오. 

6.  클러스터를 작성하십시오.
    1.  사용 가능한 위치를 검토하십시오. 표시되는 위치는 로그인한 {{site.data.keyword.containershort_notm}} 지역에 따라 다릅니다. 

        ```
        bx cs locations
        ```
        {: pre}

        CLI 출력이 [컨테이너 지역의 위치](cs_regions.html#locations)와 일치합니다.

    2.  위치를 선택하고 그 위치에서 사용할 수 있는 시스템 유형을 검토하십시오. 시스템 유형은 각 작업자 노드가 사용할 수 있는 가상 컴퓨팅 리소스를 지정합니다. 

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  퍼블릭 및 프라이빗 VLAN이 이 계정에 대한 IBM Cloud 인프라(SoftLayer)에 이미 존재하는지 확인하십시오.

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10 
        ```
        {: screen}

        퍼블릭 및 프라이빗 VLAN이 이미 존재하는 경우 일치하는 라우터를 기록해 놓으십시오. 프라이빗 VLAN 라우터는 항상 `bcr`(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 `fcr`(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. 출력 예에서는 라우터가 모두 `02a.dal10`을 포함하고 있기 때문에 프라이빗 VLAN이 퍼블릭 VLAN과 함께 사용될 수 있습니다. 

    4.  `cluster-create` 명령을 실행하십시오. 2vCPU 및 4GB 메모리로 설정된 하나의 작업자 노드를 포함하는 라이트 클러스터 또는 IBM Cloud 인프라(SoftLayer) 계정에서 선택한 수만큼 많은 작업자 노드를 포함할 수 있는 표준 클러스터 중에서 선택할 수 있습니다. 표준 클러스터를 작성하는 경우, 기본적으로 작업자 노드 디스크가 암호화되고 해당 하드웨어가 다중 IBM 고객에 의해 공유되며 사용 시간을 기준으로 비용이 청구됩니다. </br>표준 클러스터의 예: 

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch>
        ```
        {: pre}

        라이트 클러스터의 예:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>표 1. <code>bx cs cluster-create</code> 명령 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>{{site.data.keyword.Bluemix_notm}} 조직에 클러스터를 작성하는 명령입니다.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td><em>&lt;location&gt;</em>을 클러스터를 작성하려는 {{site.data.keyword.Bluemix_notm}} 위치 ID로대체하십시오. [사용 가능한 위치](cs_regions.html#locations)는 사용자가 로그인한 {{site.data.keyword.containershort_notm}} 지역에 따라 다릅니다.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>표준 클러스터를 작성 중인 경우 시스템 유형을 선택하십시오. 시스템 유형은 각 작업자 노드가 사용할 수 있는 가상 컴퓨팅 리소스를 지정합니다. 자세한 정보는 [{{site.data.keyword.containershort_notm}}의 라이트 및 표준 클러스터 비교](cs_planning.html#cs_planning_cluster_type)를 검토하십시오. 라이트 클러스터의 경우에는 시스템 유형을 정의할 필요가 없습니다. </td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>라이트 클러스터의 경우, 퍼블릭 VLAN을 정의할 필요가 없습니다. 라이트 클러스터는 IBM이 소유하고 있는 퍼블릭 VLAN에 자동으로 연결됩니다. </li>
          <li>표준 클러스터의 경우, 해당 위치의 IBM Cloud 인프라(SoftLayer) 계정에 퍼블릭 VLAN이 이미 설정되어 있으면 퍼블릭 VLAN의 ID를 입력하십시오. 계정에 퍼블릭 및 프라이빗 VLAN이 모두 없는 경우 이 옵션을 지정하지 마십시오. {{site.data.keyword.containershort_notm}}에서 사용자를 위해 자동으로 퍼블릭 VLAN을 작성합니다.<br/><br/>
          <strong>참고:</strong>: 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. </li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>라이트 클러스터의 경우, 프라이빗 VLAN을 정의할 필요가 없습니다. 라이트 클러스터는 IBM이 소유하고 있는 프라이빗 VLAN에 자동으로 연결됩니다. </li><li>표준 클러스터의 경우, 해당 위치의 IBM Cloud 인프라(SoftLayer) 계정에 이미 프라이빗 VLAN이 설정되어 있으면 프라이빗 VLAN의 ID를 입력하십시오. 계정에 퍼블릭 및 프라이빗 VLAN이 모두 없는 경우 이 옵션을 지정하지 마십시오. {{site.data.keyword.containershort_notm}}에서 사용자를 위해 자동으로 퍼블릭 VLAN을 작성합니다.<br/><br/><strong>참고:</strong>: 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다. </li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td><em>&lt;name&gt;</em>을 클러스터의 이름으로 바꾸십시오. </td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>클러스터에 포함할 작업자 노드의 수입니다. <code>--workers</code> 옵션이 지정되지 않은 경우 1개의 작업자 노드가 작성됩니다. </td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>클러스터 마스터 노드를 위한 Kubernetes 버전입니다. 이 값은 선택사항입니다. 지정되지 않는 경우 클러스터는 지원되는 Kubernetes 버전의 기본값으로 작성됩니다. 사용 가능한 버전을 보려면 <code>bx cs kube-versions</code>를 실행하십시오.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>작업자 노드는 기본적으로 디스크 암호화 기능을 합니다. [자세히 보기](cs_security.html#cs_security_worker). 암호화를 사용 안함으로 설정하려면 이 옵션을 포함하십시오. </td>
        </tr>
        </tbody></table>

7.  클러스터 작성이 요청되었는지 확인하십시오.

    ```
         bx cs clusters
        ```
    {: pre}

    **참고:** 작업자 노드 시스템을 정렬하고, 클러스터를 설정하고 계정에 프로비저닝하는 데 최대 15분이 소요될 수 있습니다. 

    클러스터의 프로비저닝이 완료되면 클러스터의 상태가 **deployed**로 변경됩니다. 

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1   
    ```
    {: screen}

8.  작업자 노드의 상태를 확인하십시오. 

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    작업자 노드가 준비되면 상태(state)가 **정상**으로 변경되며, 상태(status)는 **준비**입니다. 노드 상태(status)가 **준비**인 경우에는 클러스터에 액세스할 수 있습니다. 

    **참고:** 모든 작업자 노드에는 클러스터가 작성된 이후 수동으로 변경될 수 없는 고유 작업자 노드 ID 및 도메인 이름이 지정됩니다. 
ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 클러스터를 관리할 수 없습니다. 

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. 작성한 클러스터를 이 세션에 대한 컨텍스트로 설정하십시오. 클러스터 관련 작업을 수행할 때마다 다음 구성 단계를 완료하십시오. 
    1.  환경 변수를 설정하기 위한 명령을 가져오고 Kubernetes 구성 파일을 다운로드하십시오. 

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        구성 파일 다운로드가 완료되면 환경 변수로서 경로를 로컬 Kubernetes 구성 파일로 설정하는 데 사용할 수 있는 명령이 표시됩니다. 

        OS X에 대한 예:

        ```
         export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  `KUBECONFIG` 환경 변수를 설정하려면 터미널에 표시되는 명령을 복사하여 붙여넣기하십시오. 
    3.  `KUBECONFIG` 환경 변수가 올바르게 설정되었는지 확인하십시오. 

        OS X에 대한 예:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        출력:

        ```
         /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

10. 기본 포트 `8001`로 Kubernetes 대시보드를 실행하십시오.
    1.  기본 포트 번호로 프록시를 설정하십시오. 

        ```
        kubectl proxy
        ```
        {: pre}

        ```
         Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  웹 브라우저에서 다음 URL을 열어서 Kubernetes 대시보드를 보십시오. 

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**다음 단계: **

-   [클러스터에 앱을 배치합니다. ](cs_apps.html#cs_apps_cli)
-   [`kubectl` 명령행을 사용하여 클러스터를 관리하십시오. ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정합니다.](/docs/services/Registry/index.html)
- 방화벽이 있는 경우, 클러스터에서 아웃바운드 트래픽을 허용하거나 네트워킹 서비스를 위한 인바운드 트래픽을 허용하려면 `bx`, `kubectl` 또는 `calicotl` 명령을 사용하기 위해 [필수 포트를 열어야](cs_security.html#opening_ports) 할 수도 있습니다. 

<br />


## 개인용 및 공용 이미지 레지스트리 사용
{: #cs_apps_images}

Docker 이미지는 작성하는 모든 컨테이너의 기초가 됩니다. 이미지는 이미지를 빌드하기 위한 지시사항이 포함되어 있는 Dockerfile에서 작성됩니다. Dockerfile은 앱, 해당 앱의 구성 및 그 종속 항목과 같이 개별적으로 저장되는 해당 지시사항의 빌드 아티팩트를 참조할 수 있습니다. 일반적으로 이미지는 공용으로 액세스 가능한 레지스트리(공용 레지스트리) 또는 소규모 사용자 그룹에 대한 제한된 액세스 권한으로 설정된 레지스트리(개인용 레지스트리)에 저장됩니다.
{:shortdesc}

다음 옵션을 검토하여 이미지 레지스트리를 설정하는 방법과 레지스트리의 이미지를 사용하는 방법에 대한 정보를 찾으십시오. 

-   [IBM 제공 이미지와 사용자 고유의 개인용 Docker 이미지 관련 작업을 위해 {{site.data.keyword.registryshort_notm}}의 네임스페이스에 액세스](#bx_registry_default).
-   [Docker Hub에서 공용 이미지에 액세스](#dockerhub).
-   [다른 개인용 레지스트리에 저장된 개인용 이미지에 액세스](#private_registry). 

### IBM 제공 이미지 및 사용자 고유의 개인용 Docker 이미지 관련 작업을 위해 {{site.data.keyword.registryshort_notm}}의 네임스페이스에 액세스
{: #bx_registry_default}

{{site.data.keyword.registryshort_notm}}의 네임스페이스에 저장된 개인용 이미지나 IBM 제공 공용 이미지에서 클러스터로 컨테이너를 배치할 수 있습니다. 

시작하기 전에:

1. [{{site.data.keyword.Bluemix_notm}} 퍼블릭 또는 {{site.data.keyword.Bluemix_dedicated_notm}}의 {{site.data.keyword.registryshort_notm}}에 네임스페이스를 설정하고 이 네임스페이스에 이미지를 푸시하십시오](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [클러스터를 작성하십시오](#cs_cluster_cli). 
3. [클러스터에 CLI를 대상으로 지정하십시오](cs_cli_install.html#cs_cli_configure). 

클러스터를 작성할 때 그 클러스터에 대해 만료되지 않는 레지스트리 토큰이 자동으로 작성됩니다. 이 토큰은 IBM 제공 공용 및 사용자 고유의 개인용 Docker 이미지 관련 작업이 가능하도록 {{site.data.keyword.registryshort_notm}}에서 사용자가 설정한 임의의 네임스페이스에 대한 읽기 전용 액세스 권한을 부여하는 데 사용됩니다. 토큰은 컨테이너화된 앱을 배치할 때 Kubernetes 클러스터에 액세스할 수 있도록 Kubernetes `imagePullSecret`에 저장되어야 합니다. 클러스터가 작성되면 {{site.data.keyword.containershort_notm}}가 이 토큰을 Kubernetes `imagePullSecret`에 자동으로 저장합니다. `imagePullSecret`은 기본 Kubernetes 네임스페이스, 그 네임스페이스에 대한 ServiceAccount에서 기본 시크릿 목록 및 kube-system 네임스페이스에 추가됩니다. 

**참고:** 이 초기 설정을 사용하면 {{site.data.keyword.Bluemix_notm}} 계정의 네임스페이스에서 사용할 수 있는 이미지에서 클러스터의 **기본** 네임스페이스로 컨테이너를 배치할 수 있습니다. 클러스터의 다른 네임스페이스로 컨테이너를 배치하려는 경우 또는 다른 {{site.data.keyword.Bluemix_notm}} 지역 또는 다른 {{site.data.keyword.Bluemix_notm}} 계정에 저장된 이미지를 사용하려는 경우, [클러스터에 대해 사용자 고유의 imagePullSecret을 작성](#bx_registry_other)해야 합니다. 

클러스터의 **기본** 네임스페이스에 컨테이너를 배치하려면 구성 파일을 작성하십시오.

1.  `mydeployment.yaml`이라는 이름의 배치 구성 파일을 작성하십시오.
2.  {{site.data.keyword.registryshort_notm}}의 네임스페이스에서 사용하려는 배치 및 이미지를 정의하십시오. 

    {{site.data.keyword.registryshort_notm}}의 네임스페이스에서 개인용 이미지 사용: 

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **팁:** 네임스페이스 정보를 검색하려면 `bx cr namespace-list`를 실행하십시오.

3.  클러스터에 배치를 작성하십시오. 

    ```
     kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **팁:** IBM 제공 공용 이미지 중 하나와 같이 기존 구성 파일도 배치할 수 있습니다. 이 예에서는 미국 남부 지역에서 **ibmliberty** 이미지를 사용합니다. 

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### 다른 Kubernetes 네임스페이스에 이미지를 배치하거나 다른 {{site.data.keyword.Bluemix_notm}} 지역 및 계정의 이미지에 액세스
{: #bx_registry_other}

고유 imagePullSecret을 작성하여 컨테이너를 다른 Kubernetes 네임스페이스에 배치하거나 다른 {{site.data.keyword.Bluemix_notm}} 지역 또는 계정에 저장된 이미지를 사용하거나 {{site.data.keyword.Bluemix_dedicated_notm}}에 저장된 이미지를 사용할 수 있습니다.

시작하기 전에:

1.  [{{site.data.keyword.Bluemix_notm}} 퍼블릭 또는 {{site.data.keyword.Bluemix_dedicated_notm}}의 {{site.data.keyword.registryshort_notm}}에 네임스페이스를 설정하고 이 네임스페이스에 이미지를 푸시하십시오](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [클러스터를 작성하십시오](#cs_cluster_cli). 
3.  [클러스터에 CLI를 대상으로 지정하십시오](cs_cli_install.html#cs_cli_configure). 

고유 imagePullSecret을 작성하려면 다음을 수행하십시오.

**참고:** ImagePullSecrets는 사용하도록 지정된 Kubernetes 네임스페이스에만 유효합니다. 컨테이너를 배치하려는 모든 네임스페이스에 대해 이러한 단계를 반복하십시오. [DockerHub](#dockerhub)의 이미지에는 ImagePullSecret이 필요하지 않습니다.

1.  토큰이 없는 경우 [액세스할 레지스트리의 토큰을 작성](/docs/services/Registry/registry_tokens.html#registry_tokens_create)하십시오.
2.  {{site.data.keyword.Bluemix_notm}} 계정의 토큰을 나열하십시오.

    ```
     bx cr token-list
    ```
    {: pre}

3.  사용하려는 토큰 ID를 기록해 놓으십시오. 
4.  토큰의 값을 검색하십시오. <em>&lt;token_id&gt;</em>를 이전 단계에서 검색한 토큰의 ID로 대체하십시오. 

    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    사용자의 토큰 값이 CLI 출력의 **토큰** 필드에 표시됩니다. 

5.  토큰 정보를 저장하기 위한 Kubernetes 시크릿을 작성하십시오. 

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>표 3. 이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>필수. 시크릿을 사용하고 컨테이너를 배치하려는 클러스터의 Kubernetes 네임스페이스입니다. 클러스터의 모든 네임스페이스를 나열하려면 <code>kubectl get namespaces</code>를 실행하십시오. </td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>필수. imagePullSecret에 사용하려는 이름입니다. </td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>필수. 네임스페이스가 설정된 이미지 레지스트리에 대한 URL입니다. <ul><li>미국 남부 및 미국 동부에 설정된 네임스페이스: registry.ng.bluemix.net</li><li>미국 남부에 설정된 네임스페이스: registry.eu-gb.bluemix.net</li><li>중앙 유럽(프랑크푸르트)에 설정된 네임스페이스: registry.eu-de.bluemix.net</li><li>호주(시드니)에 설정된 네임스페이스: registry.au-syd.bluemix.net</li><li>{{site.data.keyword.Bluemix_dedicated_notm}} 레지스트리에 설정된 네임스페이스의 경우.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>필수. 개인용 레지스트리에 로그인하기 위한 사용자 이름입니다. {{site.data.keyword.registryshort_notm}}의 경우 사용자 이름이 <code>token</code>으로 설정됩니다.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>필수. 이전에 검색한 레지스트리 토큰의 값입니다. </td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>필수. Docker 이메일 주소가 있는 경우 입력하십시오. 없는 경우에는 가상의 이메일 주소(예: example a@b.c)를 입력하십시오. 이 이메일은 Kubernetes 시크릿을 작성하기 위해서는 반드시 필요하지만 작성 후에는 사용되지 않습니다. </td>
    </tr>
    </tbody></table>

6.  시크릿이 작성되었는지 확인하십시오. <em>&lt;kubernetes_namespace&gt;</em>를 imagePullSecret을 작성한 네임스페이스의 이름으로 대체하십시오. 

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  imagePullSecret을 참조하는 포드를 작성하십시오. 
    1.  `mypod.yaml`이라는 이름의 포드 구성 파일을 작성하십시오.
    2.  개인용 {{site.data.keyword.Bluemix_notm}} 레지스트리에 액세스하기 위해 사용하려는 포드 및 imagePullSecret을 정의하십시오. 

        네임스페이스의 개인용 이미지:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        {{site.data.keyword.Bluemix_notm}} 퍼블릭 이미지:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>표 4. YAML 파일 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>클러스터에 배치하려는 컨테이너의 이름입니다. </td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>이미지가 저장된 네임스페이스입니다. 사용 가능한 네임스페이스를 나열하려면 `bx cr namespace-list`를 실행하십시오. </td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>사용하려는 이미지의 이름입니다. {{site.data.keyword.Bluemix_notm}} 계정에서 사용 가능한 이미지를 나열하려면 `bx cr image-list`을 실행하십시오.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>사용하려는 이미지의 버전입니다. 태그가 지정되지 않은 경우, 기본적으로 <strong>latest</strong>로 태그가 지정된 이미지가 사용됩니다. </td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>이전에 작성한 imagePullSecret의 이름입니다. </td>
        </tr>
        </tbody></table>

   3.  변경사항을 저장하십시오. 
   4.  클러스터에 배치를 작성하십시오. 

        ```
         kubectl apply -f mypod.yaml
        ```
        {: pre}


### Docker Hub에서 공용 이미지에 액세스
{: #dockerhub}

Docker Hub에 저장된 공용 이미지를 사용하여 추가 구성 없이 컨테이너를 클러스터에 배치할 수 있습니다. 

시작하기 전에:

1.  [클러스터를 작성하십시오](#cs_cluster_cli). 
2.  [클러스터에 CLI를 대상으로 지정하십시오](cs_cli_install.html#cs_cli_configure). 

배치 구성 파일을 작성하십시오.

1.  `mydeployment.yaml`이라는 이름의 구성 파일을 작성하십시오.
2.  사용하려는 Docker Hub로부터 배치 및 공용 이미지를 정의하십시오. 다음 구성 파일은 Docker Hub에서 사용 가능한 공용 NGINX 이미지를 사용합니다.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  클러스터에 배치를 작성하십시오. 

    ```
     kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **팁:** 또는, 기존 구성 파일을 배치하십시오. 다음 예에서는 동일한 공용 NGINX 이미지를 사용하지만 클러스터에 직접 적용됩니다.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### 다른 개인용 레지스트리에 저장된 개인용 이미지에 액세스
{: #private_registry}

사용하려는 개인용 레지스트리가 이미 있는 경우, 레지스트리 신임 정보를 Kubernetes imagePullSecret에 저장하고 구성 파일에서 이 시크릿을 참조해야 합니다. 

시작하기 전에:

1.  [클러스터를 작성하십시오](#cs_cluster_cli). 
2.  [클러스터에 CLI를 대상으로 지정하십시오](cs_cli_install.html#cs_cli_configure). 

imagePullSecret을 작성하려면 다음을 수행하십시오.

**참고:** ImagePullSecrets는 사용하도록 지정된 Kubernetes 네임스페이스에만 유효합니다. {{site.data.keyword.Bluemix_notm}} 레지스트리의 이미지에서 컨테이너를 배치하려는 모든 네임스페이스에 이러한 단계를 반복하십시오. 

1.  개인용 레지스트리 신임 정보를 저장하기 위한 Kubernetes 시크릿을 작성하십시오. 

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>표 5. 이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>필수. 시크릿을 사용하고 컨테이너를 배치하려는 클러스터의 Kubernetes 네임스페이스입니다. 클러스터의 모든 네임스페이스를 나열하려면 <code>kubectl get namespaces</code>를 실행하십시오. </td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>필수. imagePullSecret에 사용하려는 이름입니다. </td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>필수. 개인용 이미지가 저장된 레지스트리에 대한 URL입니다. </td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>필수. 개인용 레지스트리에 로그인하기 위한 사용자 이름입니다. </td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>필수. 이전에 검색한 레지스트리 토큰의 값입니다. </td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>필수. Docker 이메일 주소가 있는 경우 입력하십시오. 없는 경우에는 가상의 이메일 주소(예: example a@b.c)를 입력하십시오. 이 이메일은 Kubernetes 시크릿을 작성하기 위해서는 반드시 필요하지만 작성 후에는 사용되지 않습니다. </td>
    </tr>
    </tbody></table>

2.  시크릿이 작성되었는지 확인하십시오. <em>&lt;kubernetes_namespace&gt;</em>를 imagePullSecret을 작성한 네임스페이스의 이름으로 대체하십시오. 

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  imagePullSecret을 참조하는 포드를 작성하십시오. 
    1.  `mypod.yaml`이라는 이름의 포드 구성 파일을 작성하십시오.
    2.  개인용 {{site.data.keyword.Bluemix_notm}} 레지스트리에 액세스하기 위해 사용하려는 포드 및 imagePullSecret을 정의하십시오. 개인용 레지스트리의 개인용 이미지를 사용하려면 다음을 작성하십시오. 

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>표 6. YAML 파일 컴포넌트 이해</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>작성하려는 포드의 이름입니다. </td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>클러스터에 배치하려는 컨테이너의 이름입니다. </td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>사용하려는 개인용 레지스트리의 이미지에 대한 전체 경로입니다. </td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>사용하려는 이미지의 버전입니다. 태그가 지정되지 않은 경우, 기본적으로 <strong>latest</strong>로 태그가 지정된 이미지가 사용됩니다. </td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>이전에 작성한 imagePullSecret의 이름입니다. </td>
        </tr>
        </tbody></table>

  3.  변경사항을 저장하십시오. 
  4.  클러스터에 배치를 작성하십시오. 

        ```
         kubectl apply -f mypod.yaml
        ```
        {: pre}

<br />


## 클러스터에 {{site.data.keyword.Bluemix_notm}} 서비스 추가
{: #cs_cluster_service}

기존 {{site.data.keyword.Bluemix_notm}} 서비스 인스턴스를 클러스터에 추가하여 클러스터 사용자가 앱을 클러스터에 배치할 때 {{site.data.keyword.Bluemix_notm}} 서비스에 액세스하고 이를 사용할 수 있게 합니다.
{:shortdesc}

시작하기 전에:

1. 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 
2. [{{site.data.keyword.Bluemix_notm}} 서비스의 인스턴스를 요청](/docs/manageapps/reqnsi.html#req_instance)하십시오.
   **참고:** 워싱턴 DC 위치에 서비스 인스턴스를 작성하려면 CLI를 사용해야 합니다.

**참고:**
<ul><ul>
<li>서비스 키를 지원하는
{{site.data.keyword.Bluemix_notm}} 서비스만 추가할 수 있습니다. 서비스가 서비스 키를 지원하지 않는 경우 [외부 앱이 {{site.data.keyword.Bluemix_notm}} 서비스를 사용하도록 설정](/docs/manageapps/reqnsi.html#req_instance)을 참조하십시오.</li>
<li>서비스를 추가하기 전에 클러스터와 작업자 노드가 완전히 배치되어야 합니다.</li>
</ul></ul>


서비스를 추가하려면 다음을 수행하십시오. 
2.  사용 가능한 {{site.data.keyword.Bluemix_notm}} 서비스를 나열하십시오.

    ```
     bx service list
    ```
    {: pre}

    CLI 출력 예제:

    ```
    name                      service           plan    bound apps   last operation
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  클러스터에 추가할 서비스 인스턴스의 **이름**을 기록해 놓으십시오. 
4.  서비스를 추가하는 데 사용할 클러스터 네임스페이스를 식별하십시오. 다음 옵션 중에 선택하십시오. 
    -   기존 네임스페이스를 나열하고 사용할 네임스페이스를 선택하십시오. 

        ```
         kubectl get namespaces
        ```
        {: pre}

    -   클러스터의 새 네임스페이스를 작성하십시오. 

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  서비스를 클러스터에 추가하십시오. 

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    서비스가 클러스터에 정상적으로 추가되면 서비스 인스턴스의 신임 정보를 보유하는 클러스터 시크릿이 작성됩니다. CLI 출력 예제:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  시크릿이 클러스터 네임스페이스에서 작성되었는지 확인하십시오. 

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


클러스터에 배치된 포드에서 서비스를 사용하려면 [Kubernetes 시크릿을 시크릿 볼륨으로 포드에 마운트](cs_apps.html#cs_apps_service)하여 클러스터 사용자가 {{site.data.keyword.Bluemix_notm}} 서비스의 서비스 자격 증명에 액세스할 수 있어야 합니다. 

<br />



## 클러스터 액세스 관리
{: #cs_cluster_user}

{{site.data.keyword.containershort_notm}}로 작업하는 모든 사용자에게 해당 사용자가 수행할 수 있는 조치를 판별하는 서비스 특정 사용자 역할의 조합이 지정되어야 합니다.
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 액세스 정책</dt>
<dd>Identity and Access Management에서 {{site.data.keyword.containershort_notm}} 액세스 정책은 클러스터에 대해 수행할 수 있는 클러스터 관리 조치(예: 클러스터 작성 또는 제거, 추가 작업 노드 추가 또는 제거)를 판별합니다. 이러한 정책은 인프라 정책과 함께 설정되어야 합니다. </dd>
<dt>인프라 액세스 정책</dt>
<dd>Identity and Access Management에서 인프라 액세스 정책은 {{site.data.keyword.containershort_notm}} 사용자 인터페이스 또는 CLI에서 요청되는 조치가 IBM Cloud 인프라(SoftLayer)에서 완료될 수 있도록 허용합니다. 이러한 정책은 {{site.data.keyword.containershort_notm}} 액세스 정책과 함께 설정되어야 합니다. [사용 가능한 인프라 역할에 대해 자세히 알아보십시오](/docs/iam/infrastructureaccess.html#infrapermission). </dd>
<dt>리소스 그룹</dt>
<dd>리소스 그룹은 한 번에 둘 이상의 리소스에 사용자 액세스를 신속하게 지정할 수 있도록 {{site.data.keyword.Bluemix_notm}} 서비스를 그룹으로 구성하는 방법입니다. [리소스 그룹을 사용하여 사용자를 관리하는 방법을 학습](/docs/admin/resourcegroups.html#rgs)하십시오. </dd>
<dt>Cloud Foundry 역할</dt>
<dd>Identity and Access Management에서 모든 사용자에게 Cloud Foundry 사용자 역할이 지정되어야 합니다. 이 역할은 사용자가 {{site.data.keyword.Bluemix_notm}} 계정에서 수행할 수 있는 조치(예: 다른 사용자 초대 또는 할당 사용량 보기)를 판별합니다. [사용 가능한 Cloud Foundry 역할에 대해 자세히 알아보십시오](/docs/iam/cfaccess.html#cfaccess). </dd>
<dt>Kubernetes RBAC 역할</dt>
<dd>{{site.data.keyword.containershort_notm}} 액세스 정책이 지정된 모든 사용자는 자동으로 Kubernetes RBAC 역할이 지정됩니다. Kubernetes에서 RBAC 역할은 클러스터 내부의 Kubernetes 리소스에서 수행할 수 있는 조치를 판별합니다. RBAC 역할은 기본 네임스페이스에 대해서만 설정됩니다. 클러스터 관리자는 클러스터에서 다른 네임스페이스에 대한 RBAC 역할을 추가할 수 있습니다. 자세한 정보는 Kubernetes 문서의 [RBAC 인증 사용![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)을 참조하십시오.</dd>
</dl>

이 절의 내용: 

-   [액세스 정책 및 권한](#access_ov)
-   [{{site.data.keyword.Bluemix_notm}} 계정에 사용자 추가](#add_users)
-   [사용자의 인프라 권한 사용자 정의](#infrastructure_permissions)

### 액세스 정책 및 권한
{: #access_ov}

{{site.data.keyword.Bluemix_notm}} 계정에서 사용자에게 권한을 부여할 수 있는 액세스 정책 및 권한을 검토하십시오. 운영자 및 편집자 역할에는 별도의 권한이 있습니다. 예를 들어, 사용자가 작업자 노드를 추가하고 서비스를 바인드하게 하려면 운영자와 편집자 역할 둘 다를 사용자에게 지정해야 합니다.

|{{site.data.keyword.containershort_notm}} 액세스 정책|클러스터 관리 권한|Kubernetes 리소스 권한|
|-------------|------------------------------|-------------------------------|
|관리자|이 역할은 이 계정의 모든 클러스터에 대한 편집자, 운영자 및 뷰어 역할에서 권한을 상속합니다. <br/><br/>모든 현재 서비스 인스턴스에 대해서 설정된 경우:<ul><li>라이트 또는 표준 클러스터 작성</li><li>IBM Cloud 인프라(SoftLayer) 포트폴리오에 액세스하도록 {{site.data.keyword.Bluemix_notm}} 계정의 신임 정보 설정</li><li>클러스터 제거</li><li>이 계정의 다른 기존 사용자에 대한 {{site.data.keyword.containershort_notm}} 액세스 정책 지정 및 변경. </li></ul><p>특정 클러스터 ID에 대해 설정된 경우: <ul><li>특정 클러스터 제거</li></ul></p>해당 인프라 액세스 정책: 수퍼유저<br/><br/><b>참고</b>: 시스템, VLAN 및 서브넷과 같은 리소스를 작성하려면 사용자에게 **수퍼유저** 인프라 역할이 필요합니다. |<ul><li>RBAC 역할: cluster-admin</li><li>모든 네임스페이스의 리소스에 대한 읽기/쓰기 액세스 권한</li><li>네임스페이스 내에서 역할 작성</li><li>Kubernetes 대시보드에 액세스</li><li>앱을 공용으로 사용할 수 있도록 하는 Ingress 리소스 작성</li></ul>|
|운영자|<ul><li>추가 작업자 노드를 클러스터에 추가</li><li>작업자 노드를 클러스터에서 제거</li><li>작업자 노드를 다시 부팅</li><li>작업자 노드를 다시 로드</li><li>클러스터에 서브넷 추가</li></ul><p>해당 인프라 액세스 정책: 기본 사용자</p>|<ul><li>RBAC 역할: 관리</li><li>기본 네임스페이스 내의 리소스에 대한 읽기/쓰기 액세스 권한(네임스페이스 자체에는 해당되지 않음)</li><li>네임스페이스 내에서 역할 작성</li></ul>|
|편집자<br/><br/><b>팁</b>: 앱 개발자의 경우 이 역할을 사용하십시오. |<ul><li>클러스터에 {{site.data.keyword.Bluemix_notm}} 서비스 바인드.</li><li>클러스터에 대한 {{site.data.keyword.Bluemix_notm}} 서비스 바인드 해제.</li><li>웹훅을 작성합니다. </li></ul><p>해당 인프라 액세스 정책: 기본 사용자|<ul><li>RBAC 역할: 편집</li><li>기본 네임스페이스 내부의 리소스에 대한 읽기/쓰기 액세스 권한</li></ul></p>|
|뷰어|<ul><li>클러스터 나열</li><li>클러스터의 세부사항 보기</li></ul><p>해당 인프라 액세스 정책: 보기 전용</p>|<ul><li>RBAC 역할: 보기</li><li>기본 네임스페이스 내부의 리소스에 대한 읽기 액세스 권한</li><li>Kubernetes 시크릿에 대한 읽기 액세스 권한 없음</li></ul>|
{: caption="표 7. {{site.data.keyword.containershort_notm}} 액세스 정책 및 권한" caption-side="top"}

|Cloud Foundry 액세스 정책|계정 관리 권한|
|-------------|------------------------------|
|조직 역할: 관리자|<ul><li>{{site.data.keyword.Bluemix_notm}} 계정에 사용자 추가</li></ul>| |
|영역 역할: 개발자|<ul><li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스 작성</li><li>{{site.data.keyword.Bluemix_notm}} 서비스 인스턴스를 클러스터에 바인드</li></ul>| 
{: caption="표 8. Cloud Foundry 액세스 정책 및 권한" caption-side="top"}


### {{site.data.keyword.Bluemix_notm}} 계정에 사용자 추가
{: #add_users}

{{site.data.keyword.Bluemix_notm}} 계정에 사용자를 추가하여 클러스터에 액세스를 부여할 수 있습니다.

시작하기 전에 {{site.data.keyword.Bluemix_notm}} 계정의 관리자 Cloud Foundry 역할이 지정되어 있는지 확인하십시오.

1.  [사용자를 계정에 추가](../iam/iamuserinv.html#iamuserinv)하십시오. 
2.  **액세스** 섹션에서 **서비스**를 펼치십시오.
3.  {{site.data.keyword.containershort_notm}} 액세스 역할을 지정하십시오. **액세스 지정 대상** 드롭 다운 목록에서 {{site.data.keyword.containershort_notm}} 계정(**리소스**)에만 액세스를 부여할지 아니면 계정 내 다양한 리소스의 콜렉션(**리소스 그룹**)에 액세스를 지정할지를 결정하십시오.
  -  **리소스**의 경우: 
      1. **서비스** 드롭 다운 목록에서 **{{site.data.keyword.containershort_notm}}**를 선택하십시오.
      2. **지역** 드롭 다운 목록에서 사용자를 초대할 지역을 선택하십시오. 
      3. **서비스 인스턴스** 드롭 다운 목록에서 사용자를 초대할 클러스터를 선택하십시오. 특정 클러스터의 ID를 찾으려면 `bx cs clusters`를 실행하십시오.
      4. **역할 선택** 섹션에서 역할을 선택하십시오. 역할에 대해 지원되는 조치 목록을 찾으려면 [액세스 정책 및 권한](#access_ov)을 참조하십시오. 
  - **리소스 그룹**의 경우: 
      1. **리소스 그룹** 드롭 다운 목록에서 계정의 {{site.data.keyword.containershort_notm}} 리소스 권한이 포함된 리소스 그룹을 선택하십시오.
      2. **리소스 그룹에 액세스 지정** 드롭 다운 목록에서 역할을 선택하십시오. 역할에 대해 지원되는 조치 목록을 찾으려면 [액세스 정책 및 권한](#access_ov)을 참조하십시오. 
4. [선택사항: 인프라 역할을 지정](/docs/iam/mnginfra.html#managing-infrastructure-access)하십시오. 
5. [선택사항: Cloud Foundry 역할을 지정](/docs/iam/mngcf.html#mngcf)하십시오. 
5. **사용자 초대**를 클릭하십시오. 



### 사용자의 인프라 권한 사용자 정의
{: #infrastructure_permissions}

Identity and Access Management에서 인프라 정책을 설정할 때 사용자에게 역할과 연관된 권한이 부여됩니다. 해당 권한을 사용자 정의하려면 IBM Cloud 인프라(SoftLayer)에 로그인하고 거기에서 권한을 조정해야 합니다.
{: #view_access}

예를 들어, 기본 사용자는 작업자 노드를 다시 부팅할 수 있지만 작업자 노드를 다시 로드할 수는 없습니다. 사용자에게 수퍼유저 권한을 부여하지 않고 IBM Cloud 인프라(SoftLayer) 권한을 조정하여 다시 로드 명령을 실행할 권한을 추가할 수 있습니다. 

1.  IBM Cloud 인프라(SoftLayer) 계정에 로그인하십시오.
2.  업데이트할 사용자 프로파일을 선택하십시오. 
3.  **포털 권한**에서 사용자의 액세스 권한을 사용자 정의하십시오. 예를 들어, 다시 로드 권한을 추가하려면 **디바이스** 탭에서 **OS 다시 로드 실행 및 복구 커널 시작**을 선택하십시오. 
9.  변경사항을 저장하십시오. 

<br />



## Kubernetes 마스터 업데이트
{: #cs_cluster_update}

Kubernetes는 주기적으로 [주, 부 및 패치 버전](cs_versions.html#version_types)을 업데이트하며 이는 클러스터에 영향을 줍니다. 클러스터 업데이트는 2단계 프로세스입니다. 먼저 Kubernetes 마스터를 업데이트해야 합니다. 그런 다음 각 작업자 노드를 업데이트할 수 있습니다.

기본적으로 앞으로 부 버전의 차이가 2를 넘게 Kubernetes 마스터를 업데이트할 수 없습니다. 예를 들어, 현재 마스터가 버전 1.5이고 1.8로 업데이트하려면 먼저 1.7로 업데이트해야 합니다. 업데이트를 강제로 계속할 수 있지만 2를 넘는 부 버전 업데이트로 인해 예상치 못한 결과가 발생할 수 있습니다.

**주의**: 업데이트 지시사항에 따라 테스트 클러스터를 사용하여 업데이트 중에 잠재적 앱 가동 중단 및 중단을 처리하십시오. 클러스터를 이전 버전으로 롤백할 수 없습니다.

_주요_ 또는 _보조_ 업데이트를 작성할 때 다음 단계를 완료하십시오. 

1. [Kubernetes 변경사항](cs_versions.html)을 검토하고 _마스터 이전 업데이트_로 표시된 변경사항을 작성하십시오.
2. GUI를 사용하거나 [CLI 명령](cs_cli_reference.html#cs_cluster_update)을 실행하여 Kubernetes 마스터를 업데이트하십시오.
Kubernetes 마스터를 업데이트할 때 마스터가 약 5 - 10분 동안 작동 중지됩니다. 업데이트 중에는 클러스터에 액세스하거나 클러스터를 변경할 수 없습니다. 그러나 클러스터 사용자가 배치한 작업자 노드, 앱 및 리소스는 수정되지 않고 계속 실행됩니다.
3. 업데이트가 완료되었는지 확인하십시오. {{site.data.keyword.Bluemix_notm}} 대시보드에서 Kubernetes 버전을 검토하거나 `bx cs clusters`를 실행하십시오.

Kubernetes 마스터 업데이트가 완료되면 작업자 노드를 업데이트할 수 있습니다.

<br />


## 작업자 노드 업데이트
{: #cs_cluster_worker_update}

IBM이 Kubernetes 마스터에 패치를 자동으로 적용할 때 주 및 부 업데이트를 위해 작업자 노드를 명시적으로 업데이트해야 합니다. 작업자 노드 버전은 Kubernetes 마스터보다 상위 버전일 수 없습니다. 

**주의:** 작업자 노드에 대한 업데이트로 인해 앱과 서비스의 가동이 중단될 수 있습니다.
- 포드의 외부에 저장되지 않은 경우 데이터가 삭제됩니다.

- 배치에 [복제본 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas)을 사용하여 사용 가능한 노드에서 포드를 다시 스케줄하십시오.

프로덕션 레벨 클러스터 업데이트:
- 앱의 가동 중단을 방지하려면 업데이트 프로세스를 통해 업데이트 중에 작업자 노드에서 포드를 스케줄하지 않도록 합니다. 자세한 정보는 [`kubectl drain` ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain)을 참조하십시오.
- 테스트 클러스터를 사용하여 워크로드 및 전달 프로세스가 업데이트에 영향을 받지 않는지 유효성 검증하십시오. 작업자 노드를 이전 버전으로 롤백할 수 없습니다.
- 프로덕션 레벨 클러스터에는 작업자 노드 장애를 극복할 수 있는 용량이 있어야 합니다. 클러스터에 이러한 용량이 없는 경우 클러스터를 업데이트하기 전에 작업자 노드를 추가하십시오.
- 다중 작업자 노드가 업그레이드하도록 요청되는 경우 롤링 업데이트가 수행됩니다. 클러스터에 있는 총 작업자 노드 수의 최대 20퍼센트를 동시에 업그레이드할 수 있습니다. 업그레이드 프로세스는 다른 작업자가 업그레이드를 시작하기 전에 현재 작업자 노드가 업그레이드를 완료하도록 기다립니다.


1. Kubernetes 마스터의 Kubernetes 버전을 일치시키는 [`kubectl cli` ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)의 버전을 설치하십시오.

2. [Kubernetes 변경](cs_versions.html)에서 _Update after master_로 표시되는 변경사항을 작성하십시오.

3. 작업자 노드를 업데이트하십시오.
  * {{site.data.keyword.Bluemix_notm}} 대시보드에서 업데이트하려면 클러스터의 `작업자 노드` 섹션으로 이동하여 `작업자 업데이트`를 클릭하십시오. 
  * 작업자 노드 ID를 가져오려면 `bx cs workers <cluster_name_or_id>`. 여러 작업자 노드를 선택하는 경우 작업자 노드가 한 번에 하나씩 업데이트됩니다.

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. 업데이트가 완료되었는지 확인하십시오.
  * {{site.data.keyword.Bluemix_notm}} 대시보드에서 Kubernetes 버전을 검토하거나
`bx cs workers <cluster_name_or_id>`.
  * `kubectl get nodes`를 실행하여 작업자 노드의 Kubernets 버전을 검토하십시오.
  * 일부 경우에 업데이트 후 이전 클러스터가 **NotReady** 상태의 중복된 작업자 노드를 나열할 수 있습니다. 중복 항목을 제거하려면 [문제점 해결](cs_troubleshoot.html#cs_duplicate_nodes)을 참조하십시오.

업데이트를 완료한 후:
  - 다른 클러스터에서 업데이트 프로세스를 반복하십시오.
  - 클러스터에서 작업하는 개발자에게 `kubectl` CLI를 Kubernetes 마스터의 버전으로 업데이트하도록 알리십시오.
  - Kubernetes 대시보드에 사용률 그래프가 표시되지 않으면 [`kube-dashboard` 포드를 삭제](cs_troubleshoot.html#cs_dashboard_graphs)하십시오.

<br />


## 클러스터에 서브넷 추가
{: #cs_cluster_subnet}

클러스터에 서브넷을 추가하여 사용 가능한 포터블 공인 또는 사설 IP 주소의 풀을 변경하십시오.
{:shortdesc}

{{site.data.keyword.containershort_notm}}에서 사용자는 클러스터에 네트워크 서브넷을 추가하여 Kubernetes 서비스에 대한 안정적인 포터블 IP를 추가할 수 있습니다. 이 경우 서브넷은 하나 이상의 클러스터 전체에 걸쳐 연결성을 작성하기 위해 넷마스킹과 함께 사용되지 않습니다. 대신 서브넷은 클러스터에서 해당 서비스에 액세스할 때 사용될 수 있는 영구적인 고정 IP를 서비스에 제공하는 데 사용됩니다. 

표준 클러스터를 작성하면 {{site.data.keyword.containershort_notm}}가 포터블 공인 서브넷에 5개의 공인 IP 주소를, 포터블 사설 서브넷에 5개의 사설 IP 주소를 자동으로 프로비저닝합니다. 포터블 공인 및 사설 IP 주소는 정적이며 작업자 노드 또는 클러스터가 제거되더라도 변경되지 않습니다. 각 서브넷에 대해 포터블 공인 IP 주소 중 하나와 포터블 사설 IP 주소 중 하나는 클러스터에서 다중 앱을 노출하는 데 사용할 수 있는 [애플리케이션 로드 밸런서](cs_apps.html#cs_apps_public_ingress)에 사용됩니다. 나머지 네 개의 포터블 공인 IP 주소 및 네 개의 포터블 사설 IP 주소는 [로드 밸런서 서비스 작성](cs_apps.html#cs_apps_public_load_balancer)을 통해 단일 앱을 공용으로 노출하는 데 사용될 수 있습니다. 

**참고:** 포터블 공인 IP 주소는 매월 비용이 청구됩니다. 클러스터가 프로비저닝된 후에 포터블 공인 IP 주소를 제거하도록 선택한 경우, 비록 짧은 시간 동안만 사용했어도 월별 비용을 계속 지불해야 합니다. 

### 클러스터에 대한 추가 서브넷 요청
{: #add_subnet}

클러스터에 서브넷을 지정하여 클러스터에 안정적인 포터블 공인 또는 사설 IP를 추가할 수 있습니다.

**참고:** 클러스터에 서브넷을 사용 가능하게 하면 이 서브넷의 IP 주소가 클러스터 네트워킹 목적으로 사용됩니다. IP 주소 충돌을 피하려면 한 개의 클러스터만 있는 서브넷을 사용해야 합니다. 동시에
{{site.data.keyword.containershort_notm}}의 외부에서
다른 목적으로 또는 다중 클러스터에 대한 서브넷으로 사용하지 마십시오. 

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

IBM Cloud 인프라(SoftLayer) 계정에서 서브넷을 작성하고 지정된 클러스터에서 사용 가능하도록 설정하려면 다음을 수행하십시오. 

1. 새 서브넷을 프로비저닝하십시오. 

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>표 8. 이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>클러스터를 위한 서브넷을 프로비저닝하는 명령입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td><code>&gt;cluster_name_or_id&lt;</code>를 클러스터의 이름 또는 ID로 대체하십시오. </td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td><code>&gt;subnet_size&lt;</code>를 포터블 서브넷에서 추가할 IP 주소의 수로 대체하십시오. 허용되는 값은 8, 16, 32 또는 64입니다. <p>**참고:** 서브넷에 대한 포터블 IP 주소를 추가할 때 세 개의 IP 주소를 사용하여 클러스터 내부 네트워킹을 설정하므로 이들을 애플리케이션 로드 밸런서에 대해 사용하거나 로드 밸런서 서비스를 작성하는 데 사용할 수 없습니다. 예를 들어, 8개의 포터블 공인 IP 주소를 요청하는 경우 이 중에서 5개를 사용하여 앱을 공용으로 노출할 수 있습니다. </p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td><code>&gt;VLAN_ID&lt;</code>를 포터블 공인 또는 사설 IP 주소를 할당할 공인 또는 사설 VLAN의 ID로 대체하십시오. 기존 작업자 노드가 연결되어 있는 퍼블릭 또는 프라이빗 VLAN을 선택해야 합니다. 작업자 노드의 공인 또는 사설 VLAN을 검토하려면 <code>bx cs worker-get &gt;worker_id&lt;</code> 명령을 실행하십시오. </td>
    </tr>
    </tbody></table>

2.  서브넷이 정상적으로 작성되어 클러스터에 추가되었는지 확인하십시오. 서브넷 CIDR이 **VLAN** 섹션에 나열됩니다.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### Kubernetes 클러스터에 사용자 정의 및 기존 서브넷 추가
{: #custom_subnet}

Kubernetes 클러스터에 기존의 포터블 공인 또는 사설 서브넷을 추가할 수 있습니다.

시작하기 전에 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

사용할 사용자 정의 방화벽 규칙이나 사용 가능한 IP 주소와 함께 IBM Cloud 인프라(SoftLayer) 포트폴리오에 기존 서브넷이 있는 경우 서브넷 없이 클러스터를 작성하고 클러스터가 프로비저닝할 때 클러스터에서 기존 서브넷을 사용할 수 있도록 하십시오.

1.  사용할 서브넷을 식별하십시오. 서브넷의 ID 및 VLAN ID를 기록해 두십시오. 이 예제에서 서브넷 ID는 807861이며 VLAN ID는 1901230입니다. 

    ```
     bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public      
    
    ```
    {: screen}

2.  VLAN이 있는 위치를 확인하십시오. 이 예제에서 위치는 dal10입니다. 

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10 
    ```
    {: screen}

3.  식별된 위치와 VLAN ID를 사용하여 클러스터를 작성하십시오. 새 포터블 공인 IP 서브넷 및 새 포터블 사설 IP 서브넷이 자동으로 작성되지 않도록 `--no-subnet` 플래그를 포함하십시오.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  클러스터 작성이 요청되었는지 확인하십시오.

    ```
         bx cs clusters
        ```
    {: pre}

    **참고:** 작업자 노드 시스템을 정렬하고, 클러스터를 설정하고 계정에 프로비저닝하는 데 최대 15분이 소요될 수 있습니다. 

    클러스터의 프로비저닝이 완료되면 클러스터의 상태가 **deployed**로 변경됩니다. 

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3   
    ```
    {: screen}

5.  작업자 노드의 상태를 확인하십시오. 

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    작업자 노드가 준비되면 상태(state)가 **정상**으로 변경되며, 상태(status)는 **준비**입니다. 노드 상태(status)가 **준비**인 경우에는 클러스터에 액세스할 수 있습니다. 

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  서브넷 ID를 지정하여 클러스터에 서브넷을 추가하십시오. 클러스터가 서브넷을 사용할 수 있도록 하는 경우에는 사용자가 사용할 수 있는 모든 사용 가능한 포터블 공인 IP 주소가 포함된 Kubernetes 구성 맵이 사용자를 위해 작성됩니다. 클러스터를 위한 애플리케이션 로드 밸런서가 아직 존재하지 않는 경우, 하나의 포터블 공인 IP 주소와 하나의 포터블 사설 IP 주소가 자동으로 사용되어 공인 및 사설 애플리케이션 로드 밸런서를 작성합니다. 기타 모든 포터블 공인 및 사설 IP 주소를 사용하여 사용자 앱에 대한 로드 밸런서 서비스를 작성할 수 있습니다.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### Kubernetes 클러스터에 사용자가 관리하는 서브넷 및 IP 주소 추가
{: #user_subnet}

{{site.data.keyword.containershort_notm}}에서 액세스하도록 하려는 온프레미스 네트워크의 고유한 서브넷을 제공하십시오. 그런 다음 해당 서브넷의 사설 IP 주소를 Kubernetes 클러스터의 로드 밸런서 서비스에 추가할 수 있습니다.

요구사항:
- 사용자가 관리하는 서브넷은 프라이빗 VLAN에만 추가할 수 있습니다.
- 서브넷 접두부 길이 한계는 /24 - /30입니다. 예를 들어, `203.0.113.0/24`는 253개의 사용 가능한 사설 IP 주소를 지정하지만 `203.0.113.0/30`은 1개의 사용 가능한 사설 IP 주소를 지정합니다.
- 서브넷의 첫 번째 IP 주소는 서브넷에 대한 게이트웨이로 사용되어야 합니다.

시작하기 전에: 외부 서브넷에 들어오고 나가는 네트워크 트래픽의 라우팅을 구성하십시오. 또한 온프레미스 데이터 센터 게이트웨이 디바이스와 IBM Cloud 인프라(SoftLayer) 포트폴리오의 사설 네트워크 Vyatta 간의 VPN 연결이 있는지 확인하십시오. 자세한 정보는 이 [블로그 게시물 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)을 참조하십시오.

1. 클러스터 프라이빗 VLAN의 ID를 보십시오. **VLAN** 섹션을 찾으십시오. **사용자 관리** 필드에서 _false_인 VLAN ID를 식별하십시오.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. 프라이빗 VLAN에 외부 서브넷을 추가하십시오. 포터블 사설 IP 주소가 클러스터의 구성 맵에 추가됩니다.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    예:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. 사용자 제공 서브넷이 추가되었는지 확인하십시오. **사용자 관리** 필드가 _true_입니다.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. 사설 네트워크를 통해 앱에 액세스하려면 사설 로드 밸런서 서비스 또는 사설 Ingress 애플리케이션 로드 밸런서를 추가하십시오. 서브넷에서 사설 로드 밸런서 또는 사설 Ingress 애플리케이션 로드 밸런서를 작성할 때 추가한 사설 IP 주소를 사용하려면 IP 주소를 지정해야 합니다. 그렇지 않으면 IBM Cloud 인프라(SoftLayer) 서브넷 또는 프라이빗 VLAN의 사용자 제공 서브넷에서 랜덤으로 IP 주소가 선택됩니다. 자세한 정보는 [로드 밸런서 서비스 유형을 사용하여 앱에 대한 액세스 구성](cs_apps.html#cs_apps_public_load_balancer) 또는 [사설 애플리케이션 로드 밸런서 사용](cs_apps.html#private_ingress)을 참조하십시오. 

<br />


## 클러스터에서 기존 NFS 파일 공유 사용
{: #cs_cluster_volume_create}

Kubernetes와 함께 사용할 IBM Cloud 인프라(SoftLayer) 계정의 기존 NFS 파일 공유가 이미 있는 경우, 기존 NFS 파일 공유에서 지속적 볼륨을 작성하여 수행할 수 있습니다. 지속적 볼륨은 Kubernetes 클러스터 리소스 역할을 하는 실제 하드웨어의 한 부분이며 클러스터 사용자가 이용할 수 있습니다.
{:shortdesc}

Kubernetes는 실제 하드웨어를 나타내는 지속적 볼륨과 일반적으로 클러스터 사용자가 시작하는 스토리지에 대한 요청인 지속적 볼륨 클레임을 구별합니다. 다음 다이어그램은 지속적 볼륨과 지속적 볼륨 클레임 간의 관계를 설명합니다.

![지속적 볼륨 및 지속적 볼륨 클레임 작성](images/cs_cluster_pv_pvc.png)

 다이어그램에 표시된 대로 기존 NFS 파일 공유가 Kubernetes와 함께 사용될 수 있도록 하려면 특정 크기와 액세스 모드로 지속적 볼륨을 작성하고 그 지속적 볼륨 스펙과 일치하는 지속적 볼륨 클레임을 작성해야 합니다. 지속적 볼륨과 지속적 볼륨 클레임이 일치하는 경우 서로 바인드됩니다. 바인드된 지속적 볼륨 클레임만 볼륨을 배치에 마운트하기 위해 클러스터 사용자가 사용할 수 있습니다. 이 프로세스를 지속적 스토리지의 정적 프로비저닝이라고 합니다. 

시작하기 전에 지속적 볼륨을 작성하기 위해 사용할 수 있는 기존 NFS 파일 공유가 있는지 확인하십시오. 

**참고:** 지속적 스토리지의 정적 프로비저닝은 기존 NFS 파일 공유에만 적용됩니다. 기존 NFS 파일 공유가 없는 경우, 클러스터 사용자는 지속적 볼륨을 추가하기 위해 [동적 프로비저닝](cs_apps.html#cs_apps_volume_claim) 프로세스를 사용할 수 있습니다. 

지속적 볼륨 및 일치하는 지속적 볼륨 클레임을 작성하려면 다음 단계를 따르십시오. 

1.  IBM Cloud 인프라(SoftLayer) 계정에서 지속적 볼륨 오브젝트를 작성할 NFS 파일 공유의 ID 및 경로를 검색하십시오. 또한 파일 스토리지에 클러스터의 서브넷에 대한 권한을 부여하십시오. 이 권한 부여는 클러스터에 스토리지에 대한 액세스 권한을 제공합니다. 
    1.  IBM Cloud 인프라(SoftLayer) 계정에 로그인하십시오.
    2.  **스토리지**를 클릭하십시오.
    3.  **조치** 메뉴에서 **파일 스토리지**를 클릭하고 **호스트에 권한 부여**를 선택하십시오. 
    4.  **서브넷**을 클릭하십시오. 권한을 부여한 후에는 서브넷 상의 모든 작업자 노드에 파일 스토리지에 대한 액세스 권한이 있습니다. 
    5.  메뉴에서 클러스터의 공인 VLAN의 서브넷을 선택하고 **제출**을 클릭하십시오. 서브넷을 찾아야 하는 경우에는 `bx cs cluster-get <cluster_name> --showResources`를 실행하십시오. 
    6.  파일 스토리지의 이름을 클릭하십시오. 
    7.  **마운트 포인트** 필드를 기록해 두십시오. 이 필드는 `<server>:/<path>`로 표시됩니다. 
2.  지속적 볼륨에 대한 스토리지 구성 파일을 작성하십시오. 파일 스토리지 **마운트 포인트** 필드의 서버 및 경로를 포함하십시오. 

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>표 9. YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>작성하려는 지속적 볼륨 오브젝트의 이름을 입력하십시오. </td>
    </tr>
    <tr>
    <td><code>스토리지</code></td>
    <td>기존 NFS 파일 공유의 스토리지 크기를 입력하십시오. 스토리지 크기는 기가바이트(예: 20Gi(20GB) 또는 1000Gi(1TB))로 기록되어야 하며 그 크기는 기존 파일 공유의 크기와 일치해야 합니다. </td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>액세스 모드는 지속적 볼륨이 작업자 노드에 마운트될 수 있는 방법을 정의합니다. <ul><li>ReadWriteOnce(RWO): 지속적 볼륨이 단일 작업자 노드의 배치에만 마운트될 수 있습니다. 이 지속적 볼륨에 마운트된 배치의 컨테이너는 볼륨에서 읽기 및 쓰기가 가능합니다. </li><li>ReadOnlyMany(ROX): 지속적 볼륨이 다중 작업자 노드에 호스팅된 배치에 마운트될 수 있습니다. 이 지속적 볼륨에 마운트된 배치는 볼륨에서 읽기만 가능합니다. </li><li>ReadWriteMany(RWX): 이 지속적 볼륨이 다중 작업자 노드에 호스팅된 배치에 마운트될 수 있습니다. 이 지속적 볼륨에 마운트된 배치는 볼륨에서 읽기 및 쓰기가 가능합니다. </li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>NFS 파일 공유 서버 ID를 입력하십시오. </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>지속적 볼륨 오브젝트를 작성하려는 NFS 파일 공유에 대한 경로를 입력하십시오. </td>
    </tr>
    </tbody></table>

3.  클러스터에 지속적 볼륨 오브젝트를 작성하십시오. 

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    예

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  지속적 볼륨이 작성되었는지 확인하십시오. 

    ```
    kubectl get pv
    ```
    {: pre}

5.  다른 구성 파일을 작성하여 지속적 볼륨 클레임을 작성하십시오. 지속적 볼륨 클레임이 이전에 작성한 지속적 볼륨 오브젝트와 일치하도록 `storage` 및 `accessMode`에 동일한 값을 선택해야 합니다. `storage-class` 필드는 비어 있어야 합니다. 이러한 필드 중에 지속적 볼륨과 일치하지 않는 것이 있는 경우에는 대신 새 지속적 볼륨이 자동으로 작성됩니다. 

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  지속적 볼륨 클레임을 작성하십시오. 

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  지속적 볼륨 클레임이 작성되고 지속적 볼륨 오브젝트에 바인드되었는지 확인하십시오. 이 프로세스는 몇 분 정도 소요됩니다. 

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    출력은 다음과 같이 표시됩니다. 

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


지속적 볼륨 오브젝트를 작성했으며 지속적 볼륨 클레임에 바인드했습니다. 이제 클러스터 사용자는 자신의 배치에 [지속적 볼륨 클레임을 마운트](cs_apps.html#cs_apps_volume_mount)하고 지속적 볼륨 오브젝트에서 읽거나 쓰기를 시작할 수 있습니다. 

<br />


## 클러스터 로깅 구성
{: #cs_logging}

로그는 클러스트와 앱의 문제를 해결하는 데 도움이 됩니다. 때때로 처리 또는 장기 저장을 위해 특정 위치에 로그를 전송할 수 있습니다. {{site.data.keyword.containershort_notm}}의 Kubernetes 클러스터에서 클러스터에에 대한 로그 전달을 사용으로 설정하고 로그가 전달되는 위치를 선택할 수 있습니다. **참고**: 로그 전달은 표준 클러스터에서만 지원됩니다.
{:shortdesc}

컨테이너, 애플리케이션, 작업자 노드, Kubernetes 클러스터 및 Ingress 제어기와 같은 로그 소스의 로그를 전달할 수 있습니다. 각 로그 소스에 대한 정보를 보려면 다음 표를 검토하십시오. 

|로그 소스|특성|로그 경로|
|----------|---------------|-----|
|`컨테이너`|Kubernetes 클러스터에서 실행되는 사용자의 컨테이너에 대한 로그입니다. |-|
|`application`|Kubernetes 클러스터에서 실행되는 고유 애플리케이션의 로그입니다.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`worker`|Kubernetes 클러스터 내 가상 머신 작업자 노드의 로그입니다.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Kubernetes 시스템 컴포넌트의 로그입니다.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Kubernetes 클러스터로 수신되는 네트워크 트래픽을 관리하는 Ingress 제어기가 관리하는 애플리케이션 로드 밸런서의 로그입니다. |`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="표 9. 로그 소스 특성" caption-side="top"}

### 로그 전달 사용
{: #cs_log_sources_enable}

{{site.data.keyword.loganalysislong_notm}} 또는 외부 syslog 서버로 로그를 전달할 수 있습니다. 하나의 로그 소스의 로그를 두 로그 콜렉터 서버로 전달하려면 두 로깅 구성을 작성해야 합니다.
**참고**: 애플리케이션에 대한 로그를 전달하려면 [애플리케이션에 대한 로그 전달 사용](#cs_apps_enable)을 참조하십시오.
{:shortdesc}

시작하기 전에:

1. 로그를 외부 syslog 서버로 전달하려는 경우 다음 두 가지 방법으로 syslog 프로토콜을 허용하는 서버를 설정할 수 있습니다.
  * 자체 서버를 설정하여 관리하거나 제공자가 관리하도록 하십시오. 제공자가 사용자 대신 서버를 관리하는 경우 로깅 제공자로부터 로깅 엔드포인트를 가져오십시오. 
  * 컨테이너에서 syslog를 실행하십시오. 예를 들어, 이 [배치 .yaml 파일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)을 사용하여 Kubernetes 클러스터에서 컨테이너를 실행하는 Docker 공용 이미지를 페치할 수 있습니다. 이미지는 공용 클러스터 IP 주소에 포트 `514`를 공개하고 이 공용 클러스터 IP 주소를 사용하여 syslog 호스트를 구성합니다.

2. 로그 소스가 있는 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

컨테이너, 작업자 노드, Kubernetes 시스템 컴포넌트, 애플리케이션 또는 Ingress 애플리케이션 로드 밸런서에 대한 로그 전달을 사용하려면 다음을 수행하십시오. 

1. 로그 전달 구성을 작성하십시오.

  * {{site.data.keyword.loganalysislong_notm}}에 로그를 전달하려면 다음을 수행하십시오.

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --spaceName <cluster_space> --orgName <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>표 10. 이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>{{site.data.keyword.loganalysislong_notm}} 로그 전달 구성을 작성하는 명령입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em>를 클러스터의 이름 또는 ID로 대체하십시오.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td> <em>&lt;my_log_source&gt;</em>를 로그 소스로 대체하십시오. 허용되는 값은 <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> 및 <code>ingress</code>입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td><em>&lt;kubernetes_namespace&gt;</em>를 로그를 전달할 Docker 컨테이너 네임스페이스로 대체하십시오. <code>ibm-system</code> 및 <code>kube-system</code> Kubernetes 네임스페이스의 경우 로그 전달이 지원되지 않습니다. 이 값은 컨테이너 로그 소스에 대해서만 유효하며 선택사항입니다. 네임스페이스를 지정하지 않으면 컨테이너의 모든 네임스페이스가 이 구성을 사용합니다.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td><em>&lt;ingestion_URL&gt;</em>을 {{site.data.keyword.loganalysisshort_notm}} 유입 URL로 대체하십시오. 사용 가능한 유입 URL 목록은 [여기](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)에서 찾을 수 있습니다. 유입 URL을 지정하지 않으면 클러스터가 작성된 지역의 엔드포인트가 사용됩니다. </td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td><em>&lt;ingestion_port&gt;</em>를 유입 포트로 대체하십시오. 포트를 지정하지 않으면 표준 포트 <code>9091</code>이 사용됩니다. </td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td><em>&lt;cluster_space&gt;</em>를 로그를 전송할 영역의 이름으로 대체하십시오. 영역을 지정하지 않으면 로그는 계정 레벨로 전송됩니다. </td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td><em>&lt;cluster_org&gt;</em>를 영역이 있는 조직의 이름으로 대체하십시오. 영역을 지정한 경우 이 값은 필수입니다. </td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>{{site.data.keyword.loganalysisshort_notm}}로 로그를 전송하기 위한 로그 유형입니다. </td>
    </tr>
    </tbody></table>

  * 로그를 외부 syslog 서버에 전달하려면 다음을 수행하십시오.

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>표 11. 이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>syslog 로그 전달 구성을 작성하는 명령입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em>를 클러스터의 이름 또는 ID로 대체하십시오.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td> <em>&lt;my_log_source&gt;</em>를 로그 소스로 대체하십시오. 허용되는 값은 <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> 및 <code>ingress</code>입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td><em>&lt;kubernetes_namespace&gt;</em>를 로그를 전달할 Docker 컨테이너 네임스페이스로 대체하십시오. <code>ibm-system</code> 및 <code>kube-system</code> Kubernetes 네임스페이스의 경우 로그 전달이 지원되지 않습니다. 이 값은 컨테이너 로그 소스에 대해서만 유효하며 선택사항입니다. 네임스페이스를 지정하지 않으면 컨테이너의 모든 네임스페이스가 이 구성을 사용합니다.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td><em>&lt;log_server_hostname&gt;</em>을 로그 콜렉터 서비스의 호스트 이름 또는 IP 주소로 대체하십시오. </td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em>를 로그 콜렉터 서버의 포트로 대체하십시오. 포트를 지정하지 않으면 표준 포트 <code>514</code>가 사용됩니다.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>외부 syslog 서버로 로그를 전송하기 위한 로그 유형입니다. </td>
    </tr>
    </tbody></table>

2. 로그 전달 구성이 작성되었는지 확인하십시오.

    * 클러스터의 모든 로깅 구성을 나열하려면 다음을 실행하십시오.
      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      출력 예: 

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 로그 소스의 한 가지 유형에 대한 로깅 구성을 나열하려면 다음을 실행하십시오.
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      출력 예: 

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### 애플리케이션에 대한 로그 전달 사용
{: #cs_apps_enable}

애플리케이션의 로그는 호스트 노드의 특정 디렉토리로 제한되어야 합니다. 마운트 경로를 통해 호스트 경로 볼륨을 컨테이너에 마운트하여 이를 수행할 수 있습니다. 이 마운트 경로는 애플리케이션 로그가 전송되는 컨테이너에서 디렉토리의 역할을 합니다. 볼륨 마운트를 작성하면 사전 정의된 호스트 경로 디렉토리 `/var/log/apps`가 자동으로 작성됩니다.

애플리케이션 로그 전달에 대한 다음 측면을 검토하십시오.
* 로그는 /var/log/apps 경로에서 재귀적으로 읽힙니다. 즉, /var/log/apps 경로의 서브디렉토리에 애플리케이션 로그를 배치할 수 있습니다.
* `.log` 또는 `.err` 파일 확장자를 가진 애플리케이션 로그 파일만 전달됩니다.
* 처음 로그 전달을 사용하면 애플리케이션 로그가 처음부터 읽히는 대신 사용 이후부터 읽힙니다. 즉, 애플리케이션 로깅이 사용되기 전에 이미 존재한 로그의 컨텐츠는 읽히지 않습니다. 로그는 로깅이 사용된 시점부터 읽힙니다. 하지만 처음 로그 전달이 사용된 후 로그는 항상 마지막에 중단된 위치부터 선택됩니다.
* `/var/log/apps` 호스트 경로 볼륨을 컨테이너에 마운트하면 컨테이너는 모두 이 동일한 디렉토리에 작성됩니다. 즉, 컨테이너가 동일한 파일 이름으로 작성되면 컨테이너는 호스트의 동일한 파일에 작성됩니다. 이를 의도하지 않은 경우에는 각 컨테이너에서 서로 다르게 로그 파일의 이름을 지정하여 컨테이너가 동일한 로그 파일을 겹쳐쓰지 않도록 할 수 있습니다.
* 모든 컨테이너가 동일한 파일 이름으로 작성되므로, ReplicaSets의 애플리케이션 로그를 전달하는 데 이 방법을 사용하지 마십시오. 대신 애플리케이션에서 STDOUT 및 STDERR에 로그를 쓸 수 있으며, 이는 컨테이너 로그로 선택됩니다. STDOUT 및 STDERR에 쓰여진 애플리케이션 로그를 전달하려면 [로그 전달 사용](cs_cluster.html#cs_log_sources_enable)의 단계를 수행하십시오. 

시작하기 전에 로그 소스가 있는 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

1. 애플리케이션 포드의 `.yaml` 구성 파일을 여십시오.

2. 구성 파일에 다음 `volumeMounts` 및 `volumes`를 추가하십시오.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. 포드에 볼륨을 마운트하십시오.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. 로그 전달 구성을 작성하려면 [로그 전달 사용](cs_cluster.html#cs_log_sources_enable)의 단계를 수행하십시오. 

### 로그 전달 구성 업데이트
{: #cs_log_sources_update}

컨테이너, 애플리케이션, 작업자 노드, Kubernetes 시스템 컴포넌트 또는 Ingress 애플리케이션 로드 밸런서를 위한 로깅 구성을 업데이트할 수 있습니다.
{: shortdesc}

시작하기 전에:

1. 로그 콜렉터 서버를 syslog로 변경하는 경우 다음 두 가지 방법으로 syslog 프로토콜을 허용하는 서버를 설정할 수 있습니다.
  * 자체 서버를 설정하여 관리하거나 제공자가 관리하도록 하십시오. 제공자가 사용자 대신 서버를 관리하는 경우 로깅 제공자로부터 로깅 엔드포인트를 가져오십시오. 
  * 컨테이너에서 syslog를 실행하십시오. 예를 들어, 이 [배치 .yaml 파일 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)을 사용하여 Kubernetes 클러스터에서 컨테이너를 실행하는 Docker 공용 이미지를 페치할 수 있습니다. 이미지는 공용 클러스터 IP 주소에 포트 `514`를 공개하고 이 공용 클러스터 IP 주소를 사용하여 syslog 호스트를 구성합니다.

2. 로그 소스가 있는 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

로깅 구성의 세부사항을 변경하려면 다음을 수행하십시오. 

1. 로깅 구성을 업데이트하십시오.

    ```
    bx cs logging-config-update <my_cluster> <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --spaceName <cluster_space> --orgName <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>표 12. 이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>로그 소스에 대한 로그 전달 구성을 업데이트하기 위한 명령입니다.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em>를 클러스터의 이름 또는 ID로 대체하십시오.</td>
    </tr>
    <tr>
    <td><code><em>&lt;log_config_id&gt;</em></code></td>
    <td><em>&lt;log_config_id&gt;</em>를 로그 소스 구성의 ID로 대체하십시오. </td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td> <em>&lt;my_log_source&gt;</em>를 로그 소스로 대체하십시오. 허용되는 값은 <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> 및 <code>ingress</code>입니다. </td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>로깅 유형이 <code>syslog</code>인 경우, <em>&lt;log_server_hostname_or_IP&gt;</em>를 로그 콜렉터 서비스의 호스트 이름 또는 IP 주소로 대체하십시오. 로깅 유형이 <code>ibm</code>인 경우, <em>&lt;log_server_hostname&gt;</em>을 {{site.data.keyword.loganalysislong_notm}} 유입 URL로 대체하십시오. 사용 가능한 유입 URL 목록은 [여기](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)에서 찾을 수 있습니다. 유입 URL을 지정하지 않으면 클러스터가 작성된 지역의 엔드포인트가 사용됩니다. </td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em>를 로그 콜렉터 서버의 포트로 대체하십시오. 포트를 지정하지 않으면 표준 포트 <code>514</code>가 <code>syslog</code>에 사용되고 <code>9091</code>이 <code>ibm</code>에 사용됩니다. </td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td><em>&lt;cluster_space&gt;</em>를 로그를 전송할 영역의 이름으로 대체하십시오. 이 값은 <code>ibm</code> 로그 유형에 대해서만 유효하며 선택사항입니다. 영역을 지정하지 않으면 로그는 계정 레벨로 전송됩니다. </td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td><em>&lt;cluster_org&gt;</em>를 영역이 있는 조직의 이름으로 대체하십시오. 이 값은 <code>ibm</code> 로그 유형에 대해서만 유효하며, 영역을 지정한 경우 필수입니다. </td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td><em>&lt;logging_type&gt;</em>을 사용할 새 로그 전달 프로토콜로 대체하십시오. 현재 <code>syslog</code> 및 <code>ibm</code>이 지원됩니다. </td>
    </tr>
    </tbody></table>

2. 로그 전달 구성이 업데이트되었는지 확인하십시오.

    * 클러스터의 모든 로깅 구성을 나열하려면 다음을 실행하십시오.

      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      출력 예: 

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 로그 소스의 한 가지 유형에 대한 로깅 구성을 나열하려면 다음을 실행하십시오.

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      출력 예: 

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

### 로그 전달 중지
{: #cs_log_sources_delete}

로깅 구성을 삭제하여 로그 전달을 중지할 수 있습니다.

시작하기 전에 로그 소스가 있는 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

1. 로깅 구성을 삭제하십시오.

    ```
    bx cs logging-config-rm <my_cluster> <log_config_id>
    ```
    {: pre}
    <em>&lt;my_cluster&gt;</em>를 로깅 구성이 있는 클러스터의 이름으로 대체하고 <em>&lt;log_config_id&gt;</em>를 로그 소스 구성의 ID로 대체하십시오.


### Kubernetes API 감사 로그의 로그 전달 구성
{: #cs_configure_api_audit_logs}

Kubernetes API 감사 로그는 클러스터에서 Kubernetes API 서버로의 모든 호출을 캡처합니다. Kubernetes API 감사 로그의 수집을 시작하려면 클러스터를 위해 웹후크 백엔드를 설정하도록 Kubernetes API 서버를 구성할 수 있습니다. 이 웹후크 백엔드를 사용하면 로그를 원격 서버로 전송할 수 있습니다. Kubernetes 감사 로그에 대한 자세한 정보는 Kubernetes 문서에서 <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">감사 주제<img src="../icons/launch-glyph.svg" alt="외부 링크 아이콘"></a>를 참조하십시오. 

**참고**:
* Kubernetes API 감사 로그의 전달은 Kubernetes 버전 1.7 이상에서만 지원됩니다. 
* 현재 이 로깅 구성의 모든 클러스터에 대해 기본 감사 정책이 사용됩니다. 

#### Kubernetes API 감사 로그 전달 사용
{: #cs_audit_enable}

시작하기 전에 API 서버 감사 로그를 수집할 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

1. API 서버 구성을 위한 웹후크 백엔드를 설정하십시오. 웹후크 구성은 사용자가 이 명령의 플래그에 제공하는 정보를 기반으로 작성됩니다. 이 플래그에 정보를 제공하지 않은 경우에는 기본 웹후크 구성이 사용됩니다. 

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>표 13. 이 명령의 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 이 명령의 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>클러스터의 Kubernetes API 서버 구성에 대한 옵션을 설정하는 명령입니다. </td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>클러스터의 Kubernetes API 서버에 대한 감사 웹후크 구성을 설정하는 하위 명령입니다. </td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em>를 클러스터의 이름 또는 ID로 대체하십시오.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td><em>&lt;server_URL&gt;</em>를 로그를 전송할 원격 로깅 서비스의 URL 또는 IP 주소로 대체하십시오. 비보안 서버 URL을 제공하는 경우에는 모든 인증서가 무시됩니다. 원격 서버 URL 또는 IP 주소를 지정하지 않으면 기본 QRadar 구성이 사용되고 로그는 클러스터가 있는 지역의 QRadar 인스턴스로 전송됩니다. </td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td><em>&lt;CA_cert_path&gt;</em>를 원격 로깅 서비스를 확인하는 데 사용되는 CA 인증서의 파일 경로로 대체하십시오. </td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td><em>&lt;client_cert_path&gt;</em>를 원격 로깅 서비스에 대해 인증하는 데 사용되는 클라이언트 인증서의 파일 경로로 대체하십시오. </td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td><em>&lt;client_key_path&gt;</em>를 원격 로깅 서비스에 연결하는 데 사용되는 해당 클라이언트 키의 파일 경로로 대체하십시오. </td>
    </tr>
    </tbody></table>

2. 원격 로깅 서비스의 URL을 확인하여 로그 전달이 사용으로 설정되었는지 확인하십시오. 

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    출력 예: 
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Kubernetes 마스터를 다시 시작하여 구성 업데이트를 적용하십시오. 

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

#### Kubernetes API 감사 로그 전달 중지
{: #cs_audit_delete}

클러스터의 API 서버를 위한 웹후크 백엔드 구성을 사용 안함으로 설정하여 감사 로그의 전달을 중지할 수 있습니다. 

시작하기 전에 API 서버 감사 로그 수집을 중지할 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오. 

1. 클러스터의 API 서버를 위한 웹후크 백엔드 구성을 사용 안함으로 설정하십시오. 

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Kubernetes 마스터를 다시 시작하여 구성 업데이트를 적용하십시오. 

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### 로그 보기
{: #cs_view_logs}

클러스터 및 컨테이너에 대한 로그를 보기 위해 표준 Kubernetes 및 Docker 로깅 기능으로 사용할 수 있습니다.
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

표준 클러스터의 경우 로그는 Kubernetes 클러스터를 작성할 때 로그인한 {{site.data.keyword.Bluemix_notm}} 계정에 있습니다. 클러스터를 작성하거나 로깅 구성을 작성할 때 {{site.data.keyword.Bluemix_notm}} 영역을 지정한 경우, 로그는 해당 영역에 위치합니다. 로그는 컨테이너 외부에서 모니터되고 전달됩니다. Kibana 대시보드를 사용하여 컨테이너에 대한 로그에 액세스할 수 있습니다. 로깅에 대한 자세한 정보는 [{{site.data.keyword.containershort_notm}}에 대한 로깅](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)을 참조하십시오.

**참고**: 클러스터 또는 로깅 구성을 작성할 때 영역을 지정한 경우, 계정 소유자가 로그를 보려면 해당 영역에 대한 관리자, 개발자 또는 감사자 권한이 필요합니다. {{site.data.keyword.containershort_notm}} 액세스 정책 및 권한 변경에 대한 자세한 정보는 [클러스터 액세스 관리](cs_cluster.html#cs_cluster_user)를 참조하십시오. 권한이 변경되면 로그가 나타나기 시작하는 데 최대 24시간이 걸릴 수 있습니다.

Kibana 대시보드에 액세스하려면 다음 URL 중 하나로 이동하여 클러스터를 작성한 {{site.data.keyword.Bluemix_notm}} 계정 또는 영역을 선택하십시오.
- 미국 남부 및 미국 동부: https://logging.ng.bluemix.net
- 영국 남부 및 EU 중부: https://logging.eu-fra.bluemix.net
- AP 남부: https://logging.au-syd.bluemix.net

로그 보기에 대한 자세한 정보는 [웹 브라우저에서 Kibana로 이동](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)을 참조하십시오.

#### Docker 로그
{: #cs_view_logs_docker}

기본 제공 Docker 로깅 기능을 활용하여 표준 STDOUT 및 STDERR 출력 스트림에서 활동을 검토할 수 있습니다. 자세한 정보는 [Kubernetes 클러스터에서 실행되는 컨테이너에 대한 컨테이너 로그 보기](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)를 참조하십시오. 

<br />


## 클러스터 모니터링 구성
{: #cs_monitoring}

메트릭은 클러스터의 상태와 성능을 모니터하는 데 도움이 됩니다. 성능이 저하된 상태 또는 작동되지 않는 상태가 된 작업자를 자동으로 발견하여 정정하도록 작업자 노드의 상태 모니터링을 구성할 수 있습니다. **참고**: 모니터링은 표준 클러스터에서만 지원됩니다.
{:shortdesc}

### 메트릭 보기
{: #cs_view_metrics}

표준 Kubernetes 및 Docker 기능을 사용하여 클러스터 및 앱의 상태를 모니터할 수 있습니다.
{:shortdesc}

<dl>
<dt>{{site.data.keyword.Bluemix_notm}}의 클러스터 세부사항 페이지</dt>
<dd>{{site.data.keyword.containershort_notm}}는 클러스터의 상태와 용량 및 클러스터 리소스의 사용에 대한 정보를 제공합니다. 이 GUI를 사용하면 클러스터를 확장하고 지속적 스토리지 관련 작업을 수행하며 {{site.data.keyword.Bluemix_notm}} 서비스 바인딩을 통해 클러스터에 기능을 추가할 수 있습니다. 클러스터 세부사항 페이지를 보려면 **{{site.data.keyword.Bluemix_notm}}대시보드**로 이동하고 클러스터를 선택하십시오. </dd>
<dt>Kubernetes 대시보드</dt>
<dd>Kubernetes 대시보드는 작업자 노드의 상태를 검토하고 Kubernetes 리소스를 찾으며 컨테이너형 앱을 배치하고 로깅 및 모니터링 정보를 사용하여 앱의 문제점을 해결할 수 있는 관리 웹 인터페이스입니다. Kubernetes 대시보드에 액세스하는 방법에 대한 자세한 정보는 [{{site.data.keyword.containershort_notm}}의 Kubernetes 대시보드 시작](cs_apps.html#cs_cli_dashboard)을 참조하십시오.</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>표준 클러스터의 메트릭은 Kubernetes 클러스터가 작성될 때 로그인된 {{site.data.keyword.Bluemix_notm}} 계정에 위치합니다. 클러스터를 작성할 때 {{site.data.keyword.Bluemix_notm}} 영역을 지정한 경우 메트릭은 해당 영역에 위치합니다. 컨테이너 메트릭은 클러스터에 배치된 모든 컨테이너에 대해 자동으로 수집됩니다. 이러한 메트릭이 전송되며 Grafana를 통해 사용 가능하게 됩니다. 메트릭에 대한 자세한 정보는 [{{site.data.keyword.containershort_notm}}의 모니터링](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)을 참조하십시오.<p>Grafana 대시보드에 액세스하려면 다음 URL 중 하나로 이동하여 클러스터를 작성한 {{site.data.keyword.Bluemix_notm}} 계정 또는 영역을 선택하십시오.<ul><li>미국 남부 및 미국 동부: https://metrics.ng.bluemix.net</li><li>미국 남부: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### 기타 상태 모니터링 도구
{: #cs_health_tools}

추가 모니터링 기능을 위해 다른 도구를 구성할 수 있습니다.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus는 Kubernetes에 맞게 설계된 오픈 소스 모니터링, 로깅 및 경보 도구입니다. 도구는 클러스터, 작업자 노드 및 Kubernetes 로깅 정보를 기반으로 한 배치 상태에 대한 자세한 정보를 검색합니다. 설정 정보는 [{{site.data.keyword.containershort_notm}}와 서비스 통합](cs_planning.html#cs_planning_integrations)을 참조하십시오.</dd>
</dl>

### 자동 복구를 통해 작업자 노드의 상태 모니터링 구성
{: #cs_configure_worker_monitoring}

{{site.data.keyword.containerlong_notm}} 자동 복구 시스템은 Kubernetes 버전 1.7 이상의 기존 클러스터에 배치할 수 있습니다. 자동 복구 시스템은 다양한 검사를 통해 작업자 노드 상태를 조회합니다. 자동 복구는 구성된 검사에 따라 비정상적인 작업자 노드를 발견하면 작업자 노드에서 OS 다시 로드와 같은 정정 조치를 트리거합니다. 한 번에 하나의 작업자 노드에서만 정정 조치가 이루어집니다. 다른 작업자 노드에서 정정 조치가 이루어지려면 먼저 현재 작업자 노드가 정정 조치를 완료해야 합니다.
자세한 정보는 이 [자동 복구 블로그 게시물![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)을 참조하십시오.
**참고**: 자동 복구에서는 하나 이상의 정상 노드가 올바르게 작동되어야 합니다. 둘 이상의 작업자 노드가 있는 클러스터에서만 활성 검사를 통한 자동 복구를 구성하십시오.

시작하기 전에 작업자 노드 상태를 검사할 클러스터를 [CLI의 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

1. 검사를 JSON 형식으로 정의하는 구성 맵 파일을 작성하십시오. 예를 들어, 다음 YAML 파일은 세 가지 검사(하나의 HTTP 검사와 두 개의 Kubernetes API 서버 검사)를 정의합니다.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>표 14. YAML 파일 컴포넌트 이해</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="아이디어 아이콘"/> YAML 파일 컴포넌트 이해</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>구성 이름 <code>ibm-worker-recovery-checks</code>는 상수이고 변경될 수 없습니다.</td>
    </tr>
    <tr>
    <td><code>namespace</code></td>
    <td><code>kube-system</code> 네임스페이스는 상수이고 변경될 수 없습니다.</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>자동 복구에서 사용할 검사 유형을 입력하십시오. <ul><li><code>HTTP</code>: 자동 복구는 각 노드에서 실행되는 HTTP 서버를 호출하여 노드가 올바르게 실행 중인지 여부를 판별합니다.</li><li><code>KUBEAPI</code>: 자동 복구는 Kubernetes API 서버를 호출하고 작업자 노드에서 보고된 상태 데이터를 읽습니다.</li></ul></td>
    </tr>
    <tr>
    <td><code>Resource</code></td>
    <td>검사 유형이 <code>KUBEAPI</code>인 경우 자동 복구에서 검사할 리소스 유형을 입력하십시오. 허용된 값은 <code>NODE</code> 또는 <code>PODS</code>입니다.</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>연속 실패한 검사의 수에 대한 임계값을 입력하십시오. 이 임계값에 도달하면 자동 복구가 지정된 정정 조치를 트리거합니다. 예를 들어, 값이 3이고 자동 복구가 구성된 검사에 세 번 연속 실패하면 자동 복구가 검사와 연관된 정정 조치를 트리거합니다.</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>리소스 유형이 <code>PODS</code>인 경우 [NotReady ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 상태인 작업자 노드의 포드 백분율에 대한 임계값을 입력하십시오. 이 백분율은 작업자 노드에 대해 스케줄된 총 포드 수를 기준으로 합니다. 검사에서 비정상 포드의 백분율이 임계값을 초과한다고 판별되면 하나의 오류로 계수합니다.</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>오류 임계값에 도달할 때 실행할 조치를 입력하십시오. 정정 조치는 다른 작업자가 수리되지 않는 동안에 그리고 작업자 노드가 이전 조치의 쿨오프 주기가 아닌 경우에만 실행됩니다.<ul><li><code>REBOOT</code>: 작업자 노드를 다시 부팅합니다.</li><li><code>RELOAD</code>: 클린 OS에서 작업자 노드에 필요한 모든 구성을 다시 로드합니다.</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>자동 복구가 이미 정정 조치가 실행된 노드로 인해 다른 정정 조치를 실행할 때까지 대기해야 하는 시간(초)을 입력하십시오. 쿨오프 주기는 정정 조치가 실행될 때 시작됩니다.</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>연속 검사 간 시간(초)을 입력하십시오. 예를 들어, 값이 180이면 자동 복구는 3분마다 각 노드에서 검사를 실행합니다.</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>자동 복구가 호출 오퍼레이션을 종료하기 전까지 데이터베이스에 대한 검사 호출에 걸리는 최대 시간(초)을 입력하십시오. <code>TimeoutSeconds</code> 값은 <code>IntervalSeconds</code> 값보다 작아야 합니다.</td>
    </tr>
    <tr>
    <td><code>Port</code></td>
    <td>검사 유형이 <code>HTTP</code>인 경우 HTTP 서버가 작업자 노드에서 바인드해야 하는 포트를 입력하십시오. 이 포트는 클러스터에 있는 모든 작업자 노드의 IP에 노출되어야 합니다. 자동 복구에는 서버 검사를 위해 모든 노드에서 일정한 포트 번호가 필요합니다. 사용자 정의 서버를 클러스터에 배치할 때 [DaemonSets ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)를 사용하십시오.</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>검사 유형이 <code>HTTP</code>인 경우 검사에서 리턴될 HTTP 서버 상태를 입력하십시오. 예를 들어, 값 200은 서버의 <code>OK</code> 응답을 예상함을 표시합니다.</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>검사 유형이 <code>HTTP</code>인 경우 HTTP 서버에서 요청되는 경로를 입력하십시오. 이 값은 일반적으로 모든 작업자 노드에서 실행 중인 서버의 메트릭 경로입니다.</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>검사를 사용으로 설정하려면 <code>true</code>를 입력하고 사용 안함으로 설정하려면 <code>false</code>를 입력하십시오.</td>
    </tr>
    </tbody></table>

2. 클러스터에서 구성 맵을 작성하십시오.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 적절한 검사를 통해 `kube-system` 네임스페이스에서 이름이 `ibm-worker-recovery-checks`인 구성 맵을 작성했는지 확인하십시오.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. `kube-system` 네임스페이스에서 이름이 `international-registry-docker-secret`인 Docker 가져오기 시크릿을 작성했는지 확인하십시오. 자동 복구는 {{site.data.keyword.registryshort_notm}}의 국제 Docker 레지스트리에서 호스팅됩니다. 국제 레지스트리에 대한 올바른 신임 정보가 포함된 Docker 레지스트리 시크릿을 작성하지 않은 경우 작성하여 자동 복구 시스템을 실행하십시오.

    1. {{site.data.keyword.registryshort_notm}} 플러그인을 설치하십시오. 

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. 국제 레지스트리를 대상으로 지정하십시오.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. 국제 레지스트리 토큰을 작성하십시오.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. `INTERNATIONAL_REGISTRY_TOKEN` 환경 변수를 작성된 토큰으로 설정하십시오.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. `DOCKER_EMAIL` 환경 변수를 현재 사용자로 설정하십시오. 이메일 주소는 다음 단계에서 `kubectl` 명령을 실행하는 경우에만 필요합니다.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Docker 가져오기 시크릿을 작성하십시오.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. 이 YAML 파일을 적용하여 클러스터에 자동 복구를 배치하십시오.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. 몇 분 후에 다음 명령의 출력에서 `Events` 섹션을 확인하여 자동 복구 배치의 활동을 볼 수 있습니다.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## Kubernetes 클러스터 리소스 시각화
{: #cs_weavescope}

Weave Scope는 서비스, 포드, 컨테이너, 프로세스, 노드 등을 포함하여 Kubernetes 클러스터 내의 리소스에 대한 시각적 다이어그램을 제공합니다. Weave Scope는 CPU 및 메모리에 대한 대화식 메트릭을 제공하며 컨테이너로 tail 및 exec를 실행하기 위한 도구도 제공합니다.
{:shortdesc}

시작하기 전에:

-   공용 인터넷에 클러스터 정보를 노출하지 않도록 주의하십시오. 이러한 단계를 완료하여 안전하게 Weave Scope를 배치하고 웹 브라우저에서 로컬로 이에 액세스하십시오. 
-   클러스터가 아직 없으면 [표준 클러스터를 작성](#cs_cluster_ui)하십시오. Weave Scope는 CPU를 많이 사용할 수 있습니다(특히, 앱의 경우). 라이트 클러스터가 아닌 더 큰 표준 클러스터에서 Weave Scope를 실행하십시오. 
-   클러스터에 [CLI를 대상으로 지정](cs_cli_install.html#cs_cli_configure)하고 `kubectl` 명령을 실행하십시오.


클러스터에서 Weave Scope를 사용하려면 다음을 수행하십시오. 
2.  클러스터에서 제공된 RBAC 권한 구성 파일 중 하나를 배치하십시오. 

    읽기/쓰기 권한을 사용하려면 다음을 실행하십시오. 

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    읽기 전용 권한을 사용하려면 다음을 실행하십시오. 

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    출력:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  클러스터 IP 주소로 개별적 액세스가 가능한 Weave Scope 서비스를 배치하십시오. 

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    출력:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  포트 포워딩 명령을 실행하여 컴퓨터에서 서비스를 시작하십시오. 이제 Weave Scope가 클러스터에서 구성되었으므로, 다음번에 Weave Scope에 액세스하기 위해 이전 구성 단계를 다시 완료하지 않고도 이 포트 포워딩 명령을 실행할 수 있습니다. 

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    출력:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  `http://localhost:4040` 주소로 웹 브라우저를 여십시오. 기본 컴포넌트가 배치되지 않은 경우 다음 다이어그램이 표시됩니다. 클러스터에서 Kubernetes 리소스의 토폴로지 다이어그램이나 테이블을 보도록 선택할 수 있습니다.

     <img src="images/weave_scope.png" alt="Weave Scope의 토폴로지 예" style="width:357px;" />


[Weave Scope 기능에 대해 자세히 알아보십시오 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.weave.works/docs/scope/latest/features/).

<br />


## 클러스터 제거
{: #cs_cluster_remove}

클러스터 관련 작업이 완료되면 클러스터가 더 이상 리소스를 이용하지 않도록 이를 제거할 수 있습니다.
{:shortdesc}

종량과금제 계정으로 작성된 라이트 및 표준 클러스터는 더 이상 필요하지 않은 경우 사용자가 수동으로 제거해야 합니다. 

클러스터를 삭제하면 컨테이너, 포드, 바인딩된 서비스 및 시크릿 등이 포함된 클러스터의 리소스도 삭제됩니다. 클러스터를 삭제할 때 스토리지를 삭제하지 않은 경우에는 {{site.data.keyword.Bluemix_notm}} GUI의 IBM Cloud 인프라(SoftLayer) 대시보드를 통해 스토리지를 삭제할 수 있습니다. 월별 비용 청구 주기로 인해, 매월 말일에는 지속적 볼륨 클레임을 삭제할 수 없습니다. 해당 월의 말일에 지속적 볼륨 클레임을 삭제하는 경우 다음 달이 시작될 때까지 삭제는 보류 상태를 유지합니다. 

**경고:** 지속적 스토리지에 클러스터 또는 데이터 백업이 작성되지 않았습니다. 클러스터를 삭제하면 영구적이며 실행 취소할 수 없습니다.

-   {{site.data.keyword.Bluemix_notm}} GUI에서
    1.  클러스터를 선택하고 **추가 조치...** 메뉴에서 **삭제**를 클릭하십시오. 
-   {{site.data.keyword.Bluemix_notm}} CLI에서
    1.  사용 가능한 클러스터를 나열하십시오. 

        ```
         bx cs clusters
        ```
        {: pre}

    2.  클러스터를 삭제하십시오.

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  프롬프트에 따라 클러스터 리소스 삭제 여부를 선택하십시오.

클러스터를 제거할 때 포터블 서브넷 및 이와 연관된 지속적 스토리지를 제거하도록 선택할 수 있습니다.
- 서브넷은 로드 밸런서 서비스 또는 Ingress 제어기에 포터블 공인 IP 주소를 지정하는 데 사용됩니다. 이를 보관하면 새 클러스터에서 재사용하거나 나중에 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 수동으로 삭제할 수 있습니다.
- (기존 파일 공유)[#cs_cluster_volume_create]를 사용하여 지속적 볼륨 클레임을 작성한 경우 클러스터를 삭제할 때 파일 공유를 삭제할 수 없습니다. 나중에 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 파일 공유를 수동으로 삭제해야 합니다.
- 지속적 스토리지는 데이터의 고가용성을 제공합니다. 이를 삭제하면 데이터를 복구할 수 없습니다.
