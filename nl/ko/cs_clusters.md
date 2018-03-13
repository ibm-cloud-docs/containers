---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 클러스터 설정
{: #clusters}

최대 가용성 및 용량을 위한 클러스터 설정을 설계합니다.
{:shortdesc}


## 클러스터 구성 계획
{: #planning_clusters}

표준 클러스터를 사용하여 앱 가용성을 높일 수 있습니다. 복수의 작업자 노드와 클러스터 간에 설정을 분산시키면 사용자에게 작동 중지 시간이 발생할 가능성이 낮아질 수 있습니다. 로드 밸런싱 및 격리 등의 기본 제공 기능을 사용하면 호스트, 네트워크 또는 앱에서 잠재적 장애가 발생할 때 복원성이 높아집니다.
{:shortdesc}

가용성의 정도가 증가하는 순서로 정렬된 다음의 잠재적 클러스터 설정을 검토하십시오.

![클러스터의 고가용성 단계](images/cs_cluster_ha_roadmap.png)

1.  다중 작업자 노드의 단일 클러스터
2.  동일한 지역의 서로 다른 위치에서 실행 중인 두 개의 클러스터(각각 다중 작업자 노드 보유)
3.  서로 다른 지역에서 실행 중인 두 개의 클러스터(각각 다중 작업자 노드 보유)

다음 기술을 사용하여 클러스터의 가용성을 늘리십시오.

<dl>
<dt>작업자 노드 전체에 앱 전개</dt>
<dd>개발자가 클러스터에 대해 다중 작업자 노드 전체에 컨테이너를 전개할 수 있도록 허용하십시오. 세 개의 작업자 노드 각각에서 하나의 앱 인스턴스를 사용하면 앱의 사용을 인터럽트하지 않고도 하나의 작업자 노드에서 가동 중단이 발생할 수 있습니다. [{{site.data.keyword.Bluemix_notm}} GUI](cs_clusters.html#clusters_ui) 또는 [CLI](cs_clusters.html#clusters_cli)에서 클러스터를 작성할 때 포함시킬 작업자 노드의 수를 지정할 수 있습니다. Kubernetes는 클러스터에 포함될 수 있는 작업자 노드의 최대수를 제한하므로, [작업자 노드 및 포드 할당량 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/admin/cluster-large/)을 기억하십시오.
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>클러스터 간에 앱 전개</dt>
<dd>각각 다중 작업자 노드가 있는 다중 클러스터를 작성하십시오. 하나의 클러스터에서 가동 중단이 발생하는 경우, 사용자는 또한 다른 클러스터에 배치된 앱에 계속해서 액세스할 수 있습니다.
<p>클러스터 1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>클러스터 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>서로 다른 지역의 클러스터 간에 앱 전개</dt>
<dd>서로 다른 지역의 클러스터 간에 앱을 전개하는 경우에는 사용자가 있는 지역을 기반으로 로드 밸런싱이 발생하도록 허용할 수 있습니다. 한 지역의 클러스터, 하드웨어 또는 전체 위치가 가동 중단된 경우, 다른 데이터센터에 배치된 컨테이너로 트래픽이 라우트됩니다.
<p><strong>중요:</strong> 사용자 정의 도메인을 구성한 후 이러한 명령을 사용하여 클러스터를 작성할 수 있습니다.</p>
<p>위치 1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>위치 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />


## 작업자 노드 구성 계획
{: #planning_worker_nodes}

Kubernetes 클러스터는 작업자 노드로 구성되며 Kubernetes 마스터에 의해 중앙 집중식으로 모니터링되고 관리됩니다. 클러스터 관리자는 클러스터 사용자가 클러스터에서 앱을 배치하고 실행하기 위한 모든 리소스를 보유하도록 보장하기 위해 작업자 노드의 클러스터를 설정하는 방법을 결정합니다.
{:shortdesc}

표준 클러스터를 작성하면 작업자 노드가 사용자를 대신하여 IBM Cloud 인프라(SoftLayer)에서 정렬되며 {{site.data.keyword.Bluemix_notm}}에 설정됩니다. 모든 작업자 노드에는 클러스터가 작성된 이후 변경될 수 없는 고유 작업자 노드 ID 및 도메인 이름이 지정됩니다. 사용자가 선택하는 하드웨어 격리 레벨에 따라서 작업자 노드를 공유 또는 전용 노드로 설정할 수 있습니다. 작업자 노드를 퍼블릭 VLAN 및 프라이빗 VLAN에 연결할지 또는 프라이빗 VLAN에만 연결할지를 선택할 수도 있습니다. 모든 작업자 노드는 작업자 노드에 배치된 컨테이너가 사용할 수 있는 vCPU 수, 메모리 및 디스크 공간을 판별하는 특정 시스템 유형으로 프로비저닝됩니다. Kubernetes는 클러스터에 속할 수 있는 작업자 노드의 최대수를 제한합니다. 자세한 정보는 [작업자 노드 및 포드 할당량 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/admin/cluster-large/)을 검토하십시오.


### 작업자 노드용 하드웨어
{: #shared_dedicated_node}

모든 작업자 노드는 실제 하드웨어에서 가상 머신으로 설정되어 있습니다. {{site.data.keyword.Bluemix_notm}}에서 표준 클러스터를 작성하는 경우, 기본 하드웨어를 여러 {{site.data.keyword.IBM_notm}} 고객이 공유할 것인지(멀티 테넌시) 또는 사용자만 전용으로 사용할 것인지(단일 테넌시)를 선택해야 합니다.
{:shortdesc}

멀티 테넌트 설정에서 실제 리소스(예: CPU 및 메모리)는 동일한 실제 하드웨어에 배치된 모든 가상 머신 간에 공유됩니다. 모든 가상 머신이 독립적으로 실행될 수 있도록 보장하기 위해, 가상 머신 모니터(하이퍼바이저라고도 함)는 실제 리소스를 격리된 엔티티로 세그먼트화하고 이를 전용 리소스로서 가상 머신에 할당합니다(하이퍼바이저 격리).

단일 테넌트 설정에서 모든 실제 리소스는 사용자에게만 전용으로 제공됩니다. 동일한 실제 호스트에서 가상 머신으로서 여러 작업자 노드를 배치할 수 있습니다. 멀티 테넌트 설정과 유사하게, 하이퍼바이저는 모든 작업자 노드가 사용 가능한 실제 리소스의 해당 공유를 가져오도록 보장합니다.

기본 하드웨어의 비용이 여러 고객 간에 공유되므로, 공유 노드는 일반적으로 전용 노드보다 비용이 저렴합니다. 그러나 공유 및 전용 노드 간에 결정하는 경우, 사용자는 자체 법률 부서에 문의하여 앱 환경에서 요구하는 인프라 격리 및 준수의 레벨을 논의하고자 할 수 있습니다.

무료 클러스터를 작성하면 작업자 노드가 IBM Cloud 인프라(SoftLayer) 계정에서 공유 노드로서 자동으로 프로비저닝됩니다.

### 작업자 노드에 대한 VLAN 연결
{: #worker_vlan_connection}

클러스터를 작성할 때 모든 클러스터가 IBM Cloud 인프라(SoftLayer) 계정에서 VLAN에 자동으로 연결됩니다. VLAN은 동일한 실제 회선에 연결된 것처럼 작업자 노드 및 포드의 그룹을 구성합니다. 프라이빗 VLAN은 클러스터 작성 중에 작업자 노드에 지정된 사설 IP 주소를 판별하고 퍼블릭 VLAN은 클러스터 작성 중에 작업자 노드에 지정된 공인 IP 주소를 판별합니다.

무료 클러스터의 경우 클러스터 작성 중에 기본적으로 클러스터의 작업자 노드가 IBM 소유 퍼블릭 VLAN 및 프라이빗 VLAN에 연결됩니다. 표준 클러스터의 경우 작업자 노드를 퍼블릭 VLAN 및 프라이빗 VLAN 모두에 연결하거나 프라이빗 VLAN에만 연결할 수 있습니다. 작업자 노드를 프라이빗 VLAN에만 연결하려는 경우 클러스터 작성 중에 기존 프라이빗 VLAN의 ID를 지정할 수 있습니다. 그러나 작업자 노드와 Kubernetes 마스터 간의 보안 연결을 사용으로 설정하기 위한 대체 솔루션도 구성해야 합니다. 예를 들어, 프라이빗 VLAN 작업자 노드에서 Kubernetes 마스터로 트래픽을 전달하도록 Vyatta를 구성할 수 있습니다. 자세한 정보는 [IBM Cloud 인프라(SoftLayer) 문서](https://knowledgelayer.softlayer.com/procedure/basic-configuration-vyatta)에서 "작업자 노드를 Kubernetes 마스터에 안전하게 연결하도록 사용자 정의 Vyatta 설정"을 참조하십시오.

### 작업자 노드 메모리 한계
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}}는 각 작업자 노드에 대한 메모리 한계를 설정합니다. 작업자 노드에서 실행 중인 포드가 이 메모리 한계를 초과하는 경우 포드가 제거됩니다. Kubernetes에서 이 한계는 [하드 축출 임계값 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds)이라고 합니다.
{:shortdesc}

포드가 자주 제거되면 클러스터에 작업자 노드를 추가하거나 포드에 [리소스 한계 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container)를 설정하십시오.

각 시스템 유형에는 서로 다른 메모리 용량이 있습니다. 작업자 노드에서 사용 가능한 메모리가 허용되는 최소 임계값보다 작은 경우 Kubernetes가 즉시 포드를 제거합니다. 작업자 노드가 사용 가능한 경우 포드가 다른 작업자 노드에서 다시 스케줄됩니다.

|작업자 노드 메모리 용량|작업자 노드의 최소 메모리 임계값|
|---------------------------|------------|
|4GB  | 256MB |
|16GB | 1024MB |
|64GB | 4096MB |
|128GB| 4096MB |
|242GB| 4096MB |

작업자 노드에서 사용되는 메모리 양을 검토하려면 [kubectl top node ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top)를 실행하십시오.



<br />



## GUI에서 클러스터 작성
{: #clusters_ui}

Kubernetes 클러스터는 네트워크로 구성된 작업자 노드의 세트입니다. 클러스터의 용도는 애플리케이션의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 앱을 배치하려면 우선 클러스터를 작성하고 해당 클러스터에서 작업자 노드에 대한 정의를 설정해야 합니다.
{:shortdesc}

클러스터를 작성하려면 다음을 수행하십시오.
1. 카탈로그에서 **Kubernetes 클러스터**를 선택하십시오.
2. 클러스터를 배치할 지역을 선택하십시오.
3. 클러스터 플랜의 유형을 선택하십시오. **무료** 또는 **종량과금제**를 선택할 수 있습니다. 종량과금제 플랜을 사용하면 고가용성 환경을 위한 다중 작업자 노드와 같은 기능이 있는 표준 클러스터를 프로비저닝할 수 있습니다.
4. 클러스터 세부사항을 구성하십시오.
    1. 클러스터 이름을 제공하고 Kubernetes 버전을 선택한 후 클러스터를 배치할 위치를 선택하십시오. 최고의 성능을 위해서는 실제로 사용자와 가장 가까운 위치를 선택하십시오. 사용자 국가 외부의 위치를 선택하는 경우에는 외국에서 데이터를 물리적으로 저장하기 전에 법적 인가를 받아야 할 수 있다는 점을 기억하십시오.
    2. 시스템의 유형을 선택하고 필요한 작업자 노드의 수를 지정하십시오. 시스템 유형은 각 작업자 노드에서 설정되고 컨테이너에 사용 가능한 가상 CPU, 메모리 및 디스크 공간의 양을 정의합니다.
    3. IBM Cloud 인프라(SoftLayer) 계정에서 퍼블릭 및 프라이빗 VLAN을 선택하십시오. 두 VLAN 모두 작업자 노드 간에 통신하지만 퍼블릭 VLAN은 IBM 관리 Kubernetes 마스터와도 통신합니다. 다중 클러스터에 대해 동일한 VLAN을 사용할 수 있습니다.
        **참고**: 퍼블릭 VLAN을 선택하지 않도록 결정한 경우에는 대체 솔루션을 구성해야 합니다. 자세한 정보는 [작업자 노드에 대한 VLAN 연결](#worker_vlan_connection)을 참조하십시오. 
    4. 하드웨어 유형을 선택하십시오.
        - **데디케이티드**: 작업자 노드가 사용자 계정에 전념하는 인프라에서 호스팅됩니다. 리소스가 완전히 격리됩니다.
        - **공유**: 하이퍼바이저 및 실제 하드웨어와 같은 인프라 리소스가 사용자와 다른 IBM 고객 간에 분배되지만 해당 사용자만 각 작업자 노드에 액세스할 수 있습니다. 이 옵션은 비용이 적게 들고 대부분의 경우에 충분하지만 회사 정책에 따라 성능 및 인프라 요구사항을 확인해야 할 수 있습니다.
    5. 기본적으로 **로컬 디스크 암호화**가 선택되어 있습니다. 이 선택란을 선택 취소하도록 선택하는 경우 호스트의 Docker 데이터가 암호화되지 않습니다. [암호화에 대해 자세히 알아보십시오.](cs_secure.html#encrypted_disks)
4. **클러스터 작성**을 클릭하십시오. **작업자 노드** 탭에서 작업자 노드 배치의 진행상태를 볼 수 있습니다. 배치가 완료되면 **개요** 탭에서 클러스터가 준비되었는지 확인할 수 있습니다.
    **참고:** 모든 작업자 노드에는 클러스터가 작성된 이후 수동으로 변경될 수 없는 고유 작업자 노드 ID 및 도메인 이름이 지정됩니다. 
ID 또는 도메인 이름을 변경하면 Kubernetes 마스터가 클러스터를 관리할 수 없습니다.


**다음 단계: **

클러스터가 시작되어 실행 중인 경우에는 다음 태스크를 수행할 수 있습니다.

-   [클러스터 관련 작업을 시작하도록 CLI를 설치합니다.](cs_cli_install.html#cs_cli_install)
-   [클러스터에 앱을 배치합니다. ](cs_app.html#app_cli)
-   [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정합니다.](/docs/services/Registry/index.html)
- 방화벽이 있는 경우, 클러스터에서 아웃바운드 트래픽을 허용하거나 네트워킹 서비스를 위한 인바운드 트래픽을 허용하려면 `bx`, `kubectl` 또는 `calicotl` 명령을 사용하기 위해 [필수 포트를 열어야](cs_firewall.html#firewall) 할 수도 있습니다.

<br />


## CLI에서 클러스터 작성
{: #clusters_cli}

클러스터는 네트워크로 구성된 작업자 노드의 세트입니다. 클러스터의 용도는 애플리케이션의 고가용성을 유지시키는 리소스, 노드, 네트워크 및 스토리지 디바이스의 세트를 정의하는 것입니다. 앱을 배치하려면 우선 클러스터를 작성하고 해당 클러스터에서 작업자 노드에 대한 정의를 설정해야 합니다.
{:shortdesc}

클러스터를 작성하려면 다음을 수행하십시오.
1.  {{site.data.keyword.Bluemix_notm}} CLI 및 [{{site.data.keyword.containershort_notm}} 플러그인](cs_cli_install.html#cs_cli_install)을 설치하십시오.
2.  {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 프롬프트가 표시되면 {{site.data.keyword.Bluemix_notm}} 신임 정보를 입력하십시오.

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

        퍼블릭 및 프라이빗 VLAN이 이미 존재하는 경우 일치하는 라우터를 기록해 놓으십시오. 프라이빗 VLAN 라우터는 항상 `bcr`(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 `fcr`(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이
일치해야 합니다. 출력 예에서는 라우터가 모두 `02a.dal10`을 포함하고 있기 때문에 프라이빗 VLAN이 퍼블릭 VLAN과 함께 사용될 수 있습니다.

    4.  `cluster-create` 명령을 실행하십시오. 2vCPU 및 4GB 메모리로 설정된 하나의 작업자 노드를 포함하는 무료 클러스터 또는 IBM Cloud 인프라(SoftLayer) 계정에서 선택한 수만큼 많은 작업자 노드를 포함할 수 있는 표준 클러스터 중에서 선택할 수 있습니다. 표준 클러스터를 작성하는 경우, 기본적으로 작업자 노드 디스크가 암호화되고 해당 하드웨어가 다중 IBM 고객에 의해 공유되며 사용 시간을 기준으로 비용이 청구됩니다. </br>표준 클러스터의 예:

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> 
        ```
        {: pre}

        무료 클러스터의 예:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>표. <code>bx cs cluster-create</code> 명령 컴포넌트 이해</caption>
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
        <td>표준 클러스터를 작성 중인 경우 시스템 유형을 선택하십시오. 시스템 유형은 각 작업자 노드가 사용할 수 있는 가상 컴퓨팅 리소스를 지정합니다. 자세한 정보는 [{{site.data.keyword.containershort_notm}}의 무료 및 표준 클러스터 비교](cs_why.html#cluster_types)를 검토하십시오. 무료 클러스터의 경우에는 시스템 유형을 정의할 필요가 없습니다.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>작업자 노드에 대한 하드웨어 격리의 레벨입니다. 사용자 전용으로만 실제 리소스를 사용 가능하게 하려면 dedicated를 사용하고, 실제 리소스를 다른 IBM 고객과 공유하도록 허용하려면 shared를 사용하십시오. 기본값은 shared입니다. 이 값은 표준 클러스터의 경우 선택사항이며 무료 클러스터에는 사용할 수 없습니다.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>무료 클러스터의 경우, 퍼블릭 VLAN을 정의할 필요가 없습니다. 무료 클러스터는 IBM이 소유하고 있는 퍼블릭 VLAN에 자동으로 연결됩니다.</li>
          <li>표준 클러스터의 경우, 해당 위치의 IBM Cloud 인프라(SoftLayer) 계정에 퍼블릭 VLAN이 이미 설정되어 있으면 퍼블릭 VLAN의 ID를 입력하십시오. 계정에 퍼블릭 및 프라이빗 VLAN이 모두 없는 경우 이 옵션을 지정하지 마십시오. {{site.data.keyword.containershort_notm}}에서 사용자를 위해 자동으로 퍼블릭 VLAN을 작성합니다.<br/><br/>
          <strong>참고:</strong>: 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>무료 클러스터의 경우, 프라이빗 VLAN을 정의할 필요가 없습니다. 무료 클러스터는 IBM이 소유하고 있는 프라이빗 VLAN에 자동으로 연결됩니다.</li><li>표준 클러스터의 경우, 해당 위치의 IBM Cloud 인프라(SoftLayer) 계정에 이미 프라이빗 VLAN이 설정되어 있으면 프라이빗 VLAN의 ID를 입력하십시오. 계정에 퍼블릭 및 프라이빗 VLAN이 모두 없는 경우 이 옵션을 지정하지 마십시오. {{site.data.keyword.containershort_notm}}에서 사용자를 위해 자동으로 퍼블릭 VLAN을 작성합니다.<br/><br/><strong>참고:</strong>: 프라이빗 VLAN 라우터는 항상 <code>bcr</code>(벡엔드 라우터)로 시작하고 퍼블릭 VLAN 라우터는 항상 <code>fcr</code>(프론트 엔드 라우터)로 시작합니다. 클러스터 작성 시 해당 VLAN을 사용하려면 해당 접두부 뒤의 숫자와 문자 조합이 일치해야 합니다.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td><em>&lt;name&gt;</em>을 클러스터의 이름으로 바꾸십시오.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>클러스터에 포함할 작업자 노드의 수입니다. <code>--workers</code> 옵션이 지정되지 않은 경우 1개의 작업자 노드가 작성됩니다.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>클러스터 마스터 노드를 위한 Kubernetes 버전입니다. 이 값은 선택사항입니다. 지정되지 않는 경우 클러스터는 지원되는 Kubernetes 버전의 기본값으로 작성됩니다. 사용 가능한 버전을 보려면 <code>bx cs kube-versions</code>를 실행하십시오.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>작업자 노드는 기본적으로 디스크 암호화 기능을 합니다. [자세히 보기](cs_secure.html#encrypted_disks). 암호화를 사용 안함으로 설정하려면 이 옵션을 포함하십시오.</td>
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

-   [클러스터에 앱을 배치합니다. ](cs_app.html#app_cli)
-   [`kubectl` 명령행을 사용하여 클러스터를 관리합니다. ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Docker 이미지를 저장하고 다른 사용자들과 공유하도록 {{site.data.keyword.Bluemix_notm}}에서 개인용 레지스트리를 설정합니다.](/docs/services/Registry/index.html)
- 방화벽이 있는 경우, 클러스터에서 아웃바운드 트래픽을 허용하거나 네트워킹 서비스를 위한 인바운드 트래픽을 허용하려면 `bx`, `kubectl` 또는 `calicotl` 명령을 사용하기 위해 [필수 포트를 열어야](cs_firewall.html#firewall) 할 수도 있습니다.

<br />


## 클러스터 상태
{: #states}

`bx cs clusters` 명령을 실행하고 **상태** 필드를 찾아 현재 클러스터 상태를 볼 수 있습니다. 클러스터 상태를 통해 클러스터의 가용성과 용량에 대한 정보 및 발생할 수 있는 잠재적 문제점에 대한 정보를 제공합니다.
{:shortdesc}

|클러스터 상태|이유|
|-------------|------|

|중요|Kubernetes 마스터에 도달할 수 없거나 클러스터의 모든 작업자 노드가 작동 중지되었습니다. <ol><li>클러스터의 작업자 노드를 나열하십시오.<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>각 작업자 노드의 세부사항을 가져오십시오.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li><strong>상태</strong> 및 <strong>상태</strong> 필드를 검토하여 작업자 노드가 작동 중단된 이유의 근본적인 문제점을 찾으십시오.<ul><li>작업자 노드 상태가 <strong>Provision_failed</strong>로 표시되면 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 작업자 노드를 프로비저닝하는 데 필요한 권한이 없을 수 있습니다. 필수 권한을 찾으려면 [표준 Kubernetes 클러스터를 작성하도록 IBM Cloud 인프라(SoftLayer) 포트폴리오에 대한 액세스 구성](cs_infrastructure.html#unify_accounts)을 참조하십시오.</li><li>작업자 노드 상태에 <strong>중요</strong>가 표시되고 상태가 <strong>준비되지 않음</strong>을 표시하는 경우, 작업자 노드가 IBM Cloud 인프라(SoftLayer)에 로그인하지 못할 수 있습니다. 먼저 <code>bx cs worker-reboot --hard CLUSTER WORKER</code>를 실행하여 문제점 해결을 시작하십시오. 이 명령이 성공하지 못하면 <code>bx cs worker reload CLUSTER WORKER</code>를 실행하십시오.</li><li>작업자 노드 상태에 <strong>중요</strong>가 표시되고 상태에 <strong>디스크 부족</strong>이 표시되면 작업자 노드의 용량이 부족합니다. 작업자 노드의 작업 로드를 줄이거나 클러스터에 작업자 노드를 추가하여 작업 로드의 로드 밸런스를 맞출 수 있습니다.</li><li>작업자 노드 상태에 <strong>중요</strong>가 표시되고 상태에 <strong>알 수 없음</strong>이 표시되면 Kubernetes 마스터를 사용할 수 없습니다. [{{site.data.keyword.Bluemix_notm}} 지원 티켓](/docs/get-support/howtogetsupport.html#using-avatar)을 열어 {{site.data.keyword.Bluemix_notm}} 지원에 문의하십시오.</li></ul></li></ol>|

|배치 중|Kubernetes 마스터가 아직 완전히 배치되지 않았습니다. 클러스터에 액세스할 수 없습니다.|
|정상|클러스터의 모든 작업자 노드가 시작되어 실행 중입니다. 클러스터에 액세스하고 클러스터에 앱을 배치할 수 있습니다.|
|보류 중|Kubernetes 마스터가 배치되었습니다. 작업자 노드를 프로비저닝 중이므로 아직 클러스터에서 사용할 수 없습니다. 클러스터에 액세스할 수 있지만 클러스터에 앱을 배치할 수 없습니다.|


|경고|클러스터에 있는 하나 이상의 작업자 노드를 사용할 수 없지만, 다른 작업자 노드가 사용 가능하며 워크로드를 인계받을 수 있습니다.<ol><li>클러스터의 작업자 노드를 나열하고 <strong>경고</strong> 상태를 표시하는 작업자 노드의 ID를 기록해 두십시오.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>작업자 노드의 세부사항을 가져오십시오.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li><strong>상태</strong>, <strong>상태</strong> 및 <strong>세부사항</strong> 필드를 검토하여 작업자 노드가 작동 중단된 이유의 근본적인 문제점을 찾으십시오.</li><li>작업자 노드가 메모리 또는 디스크 공간 한계에 거의 도달하면 작업자 노드의 작업 로드를 줄이거나 클러스터에 작업자 노드를 추가하여 작업 로드의 로드 밸런스를 맞출 수 있습니다.</li></ol>|

{: caption="표. 클러스터 상태" caption-side="top"}

<br />


## 클러스터 제거
{: #remove}

클러스터 관련 작업이 완료되면 클러스터가 더 이상 리소스를 이용하지 않도록 이를 제거할 수 있습니다.
{:shortdesc}

종량과금제 계정으로 작성된 무료 및 표준 클러스터가 더 이상 필요하지 않은 경우 사용자가 수동으로 이를 제거해야 합니다.

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
- 서브넷은 로드 밸런서 서비스 또는 Ingress 애플리케이션 로드 밸런서에 포터블 공인 IP 주소를 지정하는 데 사용됩니다. 이를 보관하면 새 클러스터에서 재사용하거나 나중에 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 수동으로 삭제할 수 있습니다.
- [기존 파일 공유](cs_storage.html#existing)를 사용하여 지속적 볼륨 클레임을 작성한 경우 클러스터를 삭제할 때 파일 공유를 삭제할 수 없습니다. 나중에 IBM Cloud 인프라(SoftLayer) 포트폴리오에서 파일 공유를 수동으로 삭제해야 합니다.
- 지속적 스토리지는 데이터의 고가용성을 제공합니다. 이를 삭제하면 데이터를 복구할 수 없습니다.
