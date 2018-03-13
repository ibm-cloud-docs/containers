---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-29"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# CLI 및 API 설정
{: #cs_cli_install}

{{site.data.keyword.containershort_notm}} CLI 또는 API를 사용하여 Kubernetes 클러스터를 작성하고 관리할 수 있습니다.
{:shortdesc}

<br />


## CLI 설치
{: #cs_cli_install_steps}

{{site.data.keyword.containershort_notm}}에서 Kubernetes 클러스터를 작성해서 관리하며 컨테이너화된 앱을 클러스터에 배치하기 위해 필요한 CLI를 설치하십시오.
{:shortdesc}

이 태스크에는 다음 CLI 및 플러그인을 설치하기 위한 정보가 포함되어 있습니다.

-   {{site.data.keyword.Bluemix_notm}} CLI 버전 0.5.0 이상
-   {{site.data.keyword.containershort_notm}} 플러그인
-   Kubernetes CLI 버전 1.8.6 이상
-   선택사항: {{site.data.keyword.registryshort_notm}} 플러그인
-   선택사항: Docker 버전 1.9 이상

<br>
CLI를 설치하려면 다음을 수행하십시오.

1.  {{site.data.keyword.containershort_notm}} 플러그인의 필수 소프트웨어로서 [{{site.data.keyword.Bluemix_notm}} CLI ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://clis.ng.bluemix.net/ui/home.html)를 설치하십시오. {{site.data.keyword.Bluemix_notm}} CLI를 사용하여 명령을 실행하기 위한 접두부는 `bx`입니다.

2.  {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 프롬프트가 표시되면 {{site.data.keyword.Bluemix_notm}} 신임 정보를 입력하십시오.

    ```
     bx login
    ```
    {: pre}

    **참고:** 연합 ID가 있는 경우 `bx login --sso`를 사용하여 {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 사용자 이름을 입력하고 CLI 출력에서 제공된 URL을 사용하여 일회성 패스코드를 검색하십시오. `--sso` 옵션을 사용하지 않으면 로그인에 실패하고 `--sso` 옵션을 사용하면 성공하는 경우에는 연합 ID를 보유하고 있다는 것입니다.

3.  Kubernetes 클러스터를 작성하고 작업자 노드를 관리하려면 {{site.data.keyword.containershort_notm}} 플러그인을 설치하십시오. {{site.data.keyword.containershort_notm}} 플러그인을 사용하여 명령을 실행하기 위한 접두부는 `bx cs`입니다.

    ```
    bx plugin install container-service -r Bluemix
    ```
    {: pre}

    플러그인이 올바르게 설치되었는지 확인하려면 다음 명령을 실행하십시오.

    ```
        bx plugin list
    ```
    {: pre}

    {{site.data.keyword.containershort_notm}} 플러그인은 container-service로 결과에 표시됩니다.

4.  Kubernetes 대시보드의 로컬 버전을 보고 클러스터에 앱을 배치하려면 [Kubernetes CLI를 설치 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tasks/tools/install-kubectl/)하십시오. Kubernetes CLI를 사용하여 명령을 실행하기 위한 접두부는 `kubectl`입니다.

    1.  전체 기능 호환성을 위해 사용하려는 Kubernetes 클러스터 버전과 일치하는 Kubernetes CLI 버전을 다운로드하십시오. 현재 {{site.data.keyword.containershort_notm}} 기본 Kubernetes 버전은 1.8.6입니다.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

        **팁:** Windows를 사용하는 경우, {{site.data.keyword.Bluemix_notm}} CLI와 동일한 디렉토리에 Kubernetes CLI를 설치하십시오. 이 설정을 사용하면 나중에 명령을 실행할 때 일부 파일 경로 변경이 필요하지 않습니다.

    2.  OSX 및 Linux 사용자의 경우, 다음 단계를 완료하십시오.
        1.  실행 파일을 `/usr/local/bin` 디렉토리로 이동하십시오.

            ```
             mv /<path_to_file>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  `/usr/local/bin`이 `PATH` 시스템 변수에 나열되어 있는지 확인하십시오. `PATH` 변수에는 운영 체제가 실행 파일을 찾을 수 있는 모든 디렉토리가 포함되어 있습니다. `PATH` 변수에 나열된 디렉토리는 서로 다른 용도로 사용됩니다. `/usr/local/bin`은 시스템 관리자가 수동으로 설치했으며 운영 체제의 일부가 아닌 소프트웨어의 실행 파일을 저장하는 데 사용됩니다.

            ```
             echo $PATH
            ```
            {: pre}

            CLI 출력 예제:

            ```
             /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  파일을 실행 가능하도록 설정하십시오.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  개인용 이미지 저장소를 관리하려면 {{site.data.keyword.registryshort_notm}} 플러그인을 설치하십시오. 이 플러그인을 사용하여 IBM이 호스팅하는 멀티 테넌트, 고가용성 및 확장 가능한 개인용 이미지 레지스트리에서 사용자 고유의 네임스페이스를 설정할 수 있으며 Docker 이미지를 저장하고 이를 다른 사용자와 공유할 수 있습니다. Docker 이미지는 클러스터로 컨테이너를 배치하는 데 필요합니다. 레지스트리 명령을 실행하기 위한 접두부는 `bx cr`입니다.

    ```
    bx plugin install container-registry -r Bluemix
    ```
    {: pre}

    플러그인이 올바르게 설치되었는지 확인하려면 다음 명령을 실행하십시오.

    ```
        bx plugin list
    ```
    {: pre}

    플러그인이 container-registry로서 결과에 표시됩니다.

6.  로컬에 이미지를 빌드하고 레지스트리 네임스페이스에 푸시하려면 [Docker를 설치 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.docker.com/community-edition#/download)하십시오. Windows 8 이하를 사용 중인 경우 [Docker Toolbox ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.docker.com/toolbox/toolbox_install_windows/)를 대신 설치할 수 있습니다. Docker CLI는 앱을 이미지로 빌드하는 데 사용됩니다. Docker CLI를 사용하여 명령을 실행하기 위한 접두부는 `docker`입니다.

다음으로 [{{site.data.keyword.containershort_notm}}의 CLI에서 Kubernetes 클러스터 작성](cs_clusters.html#clusters_cli)을 시작하십시오.

이러한 CLI에 대한 참조 정보는 해당 도구의 문서를 참조하십시오.

-   [`bx` 명령](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [`bx cs` 명령](cs_cli_reference.html#cs_cli_reference)
-   [`kubectl` 명령 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
-   [`bx cr` 명령](/docs/cli/plugins/registry/index.html)

<br />


## `kubectl`을 실행하도록 CLI 구성
{: #cs_cli_configure}

Kubernetes CLI와 함께 제공되는 명령을 사용하여 {{site.data.keyword.Bluemix_notm}}에서 클러스터를 관리할 수 있습니다. Kubernetes 1.8.6에서 사용 가능한 모든 `kubectl` 명령은 {{site.data.keyword.Bluemix_notm}}의 클러스터와 함께 사용할 수 있도록 지원됩니다. 클러스터를 작성한 후, 로컬 CLI에 대한 컨텍스트를 환경 변수가 있는 해당 클러스터로 설정하십시오. 그런 다음, Kubernetes `kubectl` 명령을 실행하여 {{site.data.keyword.Bluemix_notm}}에서 클러스터 관련 작업을 수행할 수 있습니다.
{:shortdesc}

`kubectl` 명령을 실행하려면 우선 [필수 CLI를 설치](#cs_cli_install)하고 [클러스터를 작성](cs_clusters.html#clusters_cli)하십시오.

1.  {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 프롬프트가 표시되면 {{site.data.keyword.Bluemix_notm}} 신임 정보를 입력하십시오. {{site.data.keyword.Bluemix_notm}} 지역을 지정하려면 [API 엔드포인트를 포함](cs_regions.html#bluemix_regions)하십시오.

      ```
     bx login
      ```
      {: pre}

      **참고:** 연합 ID가 있는 경우 `bx login --sso`를 사용하여 {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 사용자 이름을 입력하고 CLI 출력에서 제공된 URL을 사용하여 일회성 패스코드를 검색하십시오. `--sso` 옵션을 사용하지 않으면 로그인에 실패하고 `--sso` 옵션을 사용하면 성공하는 경우에는 연합 ID를 보유하고 있다는 것입니다.

  2.  {{site.data.keyword.Bluemix_notm}} 계정을 선택하십시오. 여러 {{site.data.keyword.Bluemix_notm}} 조직에 지정된 경우에는 Kubernetes 클러스터가 작성된 조직을 선택하십시오. 클러스터는 조직마다 고유하지만 {{site.data.keyword.Bluemix_notm}} 영역에는 독립적입니다. 따라서 영역을 선택할 필요가 없습니다.

  3.  이전에 선택한 {{site.data.keyword.Bluemix_notm}} 지역 이외의 지역에 Kubernetes 클러스터를 작성하거나 액세스하려면 `bx cs region-set`를 실행하십시오.

  4.  클러스터의 이름을 가져오려면 계정에 있는 모든 클러스터를 나열하십시오.

      ```
     bx cs clusters
      ```
      {: pre}

  5.  작성한 클러스터를 이 세션에 대한 컨텍스트로 설정하십시오. 클러스터 관련 작업을 수행할 때마다 다음 구성 단계를 완료하십시오.
      1.  환경 변수를 설정하기 위한 명령을 가져오고 Kubernetes 구성 파일을 다운로드하십시오.

          ```
        bx cs cluster-config <cluster_name_or_id>
          ```
          {: pre}

          구성 파일을 다운로드하고 나면 환경 변수로서 경로를 로컬 Kubernetes 구성 파일로 설정하는 데 사용할 수 있는 명령이 표시됩니다.

          예:

          ```
         export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
          ```
          {: screen}

      2.  `KUBECONFIG` 환경 변수를 설정하려면 터미널에 표시되는 명령을 복사하여 붙여넣기하십시오.
      3.  `KUBECONFIG` 환경 변수가 올바르게 설정되었는지 확인하십시오.

          예:

          ```
        echo $KUBECONFIG
          ```
          {: pre}

          출력:
          ```
         /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
          ```
          {: screen}

  6.  Kubernetes CLI 서버 버전을 확인하여 `kubectl` 명령이 올바르게 실행되는지 확인하십시오.

      ```
     kubectl version  --short
      ```
      {: pre}

      출력 예:

      ```
      Client Version: v1.8.6
      Server Version: v1.8.6
      ```
      {: screen}

이제 `kubectl` 명령을 실행하여 {{site.data.keyword.Bluemix_notm}}에서 클러스터를 관리할 수 있습니다. 명령의 전체 목록은 [Kubernetes 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)를 참조하십시오.

**팁:** Windows를 사용 중이며 Kubernetes CLI가 {{site.data.keyword.Bluemix_notm}} CLI와 동일한 디렉토리에 설치되지 않은 경우, `kubectl` 명령을 정상적으로 실행하려면 Kubernetes CLI가 설치된 경로로 디렉토리를 변경해야 합니다.


<br />


## CLI 업데이트
{: #cs_cli_upgrade}

새 기능을 사용하기 위해 CLI를 주기적으로 업데이트하고자 할 수 있습니다.
{:shortdesc}

이 태스크에는 다음의 CLI를 업데이트하기 위한 정보가 포함되어 있습니다.

-   {{site.data.keyword.Bluemix_notm}} CLI 버전 0.5.0 이상
-   {{site.data.keyword.containershort_notm}} 플러그인
-   Kubernetes CLI 버전 1.8.6 이상
-   {{site.data.keyword.registryshort_notm}} 플러그인
-   Docker 버전 1.9. 이상

<br>
CLI를 업데이트하려면 다음을 수행하십시오.

1.  {{site.data.keyword.Bluemix_notm}} CLI를 업데이트하십시오. [최신 버전 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://clis.ng.bluemix.net/ui/home.html)을 다운로드하고 설치 프로그램을 실행하십시오.

2. {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 프롬프트가 표시되면 {{site.data.keyword.Bluemix_notm}} 신임 정보를 입력하십시오. {{site.data.keyword.Bluemix_notm}} 지역을 지정하려면 [API 엔드포인트를 포함](cs_regions.html#bluemix_regions)하십시오.

    ```
     bx login
    ```
    {: pre}

     **참고:** 연합 ID가 있는 경우 `bx login --sso`를 사용하여 {{site.data.keyword.Bluemix_notm}} CLI에 로그인하십시오. 사용자 이름을 입력하고 CLI 출력에서 제공된 URL을 사용하여 일회성 패스코드를 검색하십시오. `--sso` 옵션을 사용하지 않으면 로그인에 실패하고 `--sso` 옵션을 사용하면 성공하는 경우에는 연합 ID를 보유하고 있다는 것입니다.

3.  {{site.data.keyword.containershort_notm}} 플러그인을 업데이트하십시오.
    1.  {{site.data.keyword.Bluemix_notm}} 플러그인 저장소에서 업데이트를 설치하십시오.

        ```
        bx plugin update container-service -r Bluemix
        ```
        {: pre}

    2.  다음 명령을 실행하고 설치된 플러그인의 목록을 확인하여 플러그인 설치를 확인하십시오.

        ```
        bx plugin list
        ```
        {: pre}

        {{site.data.keyword.containershort_notm}} 플러그인은 container-service로 결과에 표시됩니다.

    3.  CLI를 초기화하십시오.

        ```
         bx cs init
        ```
        {: pre}

4.  Kubernetes CLI를 업데이트하십시오.
    1.  사용할 계획인 Kubernetes 클러스터 버전과 일치하는 Kubernetes CLI 버전으로 업데이트하십시오. 현재 {{site.data.keyword.containershort_notm}} 기본 Kubernetes 버전은 1.8.6입니다.

        OS X:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows:   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

        **팁:** Windows를 사용하는 경우, {{site.data.keyword.Bluemix_notm}} CLI와 동일한 디렉토리에 Kubernetes CLI를 설치하십시오. 이 설정을 사용하면 나중에 명령을 실행할 때 일부 파일 경로 변경이 필요하지 않습니다.

    2.  OSX 및 Linux 사용자의 경우, 다음 단계를 완료하십시오.
        1.  실행 파일을 `/usr/local/bin` 디렉토리로 이동하십시오.

            ```
             mv /<path_to_file>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  `/usr/local/bin`이 `PATH` 시스템 변수에 나열되어 있는지 확인하십시오. `PATH` 변수에는 운영 체제가 실행 파일을 찾을 수 있는 모든 디렉토리가 포함되어 있습니다. `PATH` 변수에 나열된 디렉토리는 서로 다른 용도로 사용됩니다. `/usr/local/bin`은 시스템 관리자가 수동으로 설치했으며 운영 체제의 일부가 아닌 소프트웨어의 실행 파일을 저장하는 데 사용됩니다.

            ```
             echo $PATH
            ```
            {: pre}

            CLI 출력 예제:

            ```
             /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  파일을 실행 가능하도록 설정하십시오.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  {{site.data.keyword.registryshort_notm}} 플러그인을 업데이트하십시오.
    1.  {{site.data.keyword.Bluemix_notm}} 플러그인 저장소에서 업데이트를 설치하십시오.

        ```
        bx plugin update container-registry -r Bluemix
        ```
        {: pre}

    2.  다음 명령을 실행하고 설치된 플러그인의 목록을 확인하여 플러그인 설치를 확인하십시오.

        ```
        bx plugin list
        ```
        {: pre}

        레지스트리 플러그인이 container-registry로 결과에 표시됩니다.

6.  Docker를 업데이트하십시오.
    -   Docker Community Edition을 사용 중인 경우 Docker를 시작하고 **Docker** 아이콘을 클릭한 후
**업데이트 확인**을 클릭하십시오.
    -   Docker Toolbox를 사용 중인 경우 [최신 버전![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.docker.com/toolbox/toolbox_install_windows/)을 다운로드하고 설치 프로그램을 실행하십시오.

<br />


## CLI 설치 제거
{: #cs_cli_uninstall}

CLI가 더 이상 필요하지 않으면 이를 설치 제거할 수 있습니다.
{:shortdesc}

이 태스크에는 다음의 CLI를 제거하기 위한 정보가 포함되어 있습니다.


-   {{site.data.keyword.containershort_notm}} 플러그인
-   Kubernetes CLI 버전 1.8.6 이상
-   {{site.data.keyword.registryshort_notm}} 플러그인
-   Docker 버전 1.9. 이상

<br>
CLI를 설치 제거하려면 다음을 수행하십시오.

1.  {{site.data.keyword.containershort_notm}} 플러그인을 설치 제거하십시오.

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  {{site.data.keyword.registryshort_notm}} 플러그인을 설치 제거하십시오.

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  다음 명령을 실행하고 설치된 플러그인의 목록을 확인하여 플러그인이 설치 제거되었는지 확인하십시오.

    ```
        bx plugin list
    ```
    {: pre}

    container-service 및 container-registry 플러그인이 결과에 표시되지 않습니다.





6.  Docker를 설치 제거하십시오. Docker를 설치 제거하는 지시사항은 사용 중인 운영 체제에 따라 다릅니다.

    - [OSX ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset)
    - [Linux ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce)
    - [Windows ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://docs.docker.com/toolbox/toolbox_install_windows/#how-to-uninstall-toolbox)

<br />


## API로 클러스터 배치 자동화
{: #cs_api}

{{site.data.keyword.containershort_notm}} API를 사용하여 Kubernetes 클러스터의 작성, 배치 및 관리를 자동화할 수 있습니다.
{:shortdesc}

{{site.data.keyword.containershort_notm}} API는 헤더 정보가 필요합니다. 이 헤더 정보는 API 요청에 사용자가 제공해야 하며 사용하려는 API에 따라 다를 수 있습니다. API에 헤더 정보가 필요한지 판별하려면 [{{site.data.keyword.containershort_notm}} API 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://us-south.containers.bluemix.net/swagger-api)를 참조하십시오.

**참고:** {{site.data.keyword.containershort_notm}}에 인증하려면 {{site.data.keyword.Bluemix_notm}} 신임 정보를 사용하여 생성되고, 클러스터가 작성된 {{site.data.keyword.Bluemix_notm}} 계정 ID를 포함하는 IAM(Identity and Access Management) 토큰을 제공해야 합니다. {{site.data.keyword.Bluemix_notm}}로 인증하는 방법에 따라 IAM 토큰 작성을 자동화하기 위한 다음 옵션 중에서 선택할 수 있습니다.

<table>
<thead>
<th>{{site.data.keyword.Bluemix_notm}} ID</th>
<th>내 옵션</th>
</thead>
<tbody>
<tr>
<td>비연합 ID</td>
<td><ul><li><strong>{{site.data.keyword.Bluemix_notm}} 사용자 이름 및 비밀번호:</strong> 이 주제의 단계에 따라 IAM 액세스 토큰 작성을 완전히 자동화할 수 있습니다.</li>
<li><strong>{{site.data.keyword.Bluemix_notm}} API 키 생성:</strong> {{site.data.keyword.Bluemix_notm}} 사용자 이름 및 비밀번호 사용의 대안으로 <a href="../iam/apikeys.html#manapikey" target="_blank">{{site.data.keyword.Bluemix_notm}} API 키를 사용</a>할 수 있습니다. {{site.data.keyword.Bluemix_notm}} API 키는 해당 API 키가 생성된 {{site.data.keyword.Bluemix_notm}} 계정에 종속됩니다. {{site.data.keyword.Bluemix_notm}} API 키를 동일한 IAM 토큰의 다른 계정 ID와 결합할 수 없습니다. {{site.data.keyword.Bluemix_notm}} API 키의 기반이 되는 계정 이외의 계정으로 작성된 클러스터에 액세스하려면 계정에 로그인하여 새 API 키를 생성해야 합니다. </li></ul></tr>
<tr>
<td>연합 ID</td>
<td><ul><li><strong>{{site.data.keyword.Bluemix_notm}} API 키 생성:</strong> <a href="../iam/apikeys.html#manapikey" target="_blank">{{site.data.keyword.Bluemix_notm}} API 키</a>는 해당 API 키가 생성된 {{site.data.keyword.Bluemix_notm}} 계정에 종속됩니다. {{site.data.keyword.Bluemix_notm}} API 키를 동일한 IAM 토큰의 다른 계정 ID와 결합할 수 없습니다. {{site.data.keyword.Bluemix_notm}} API 키의 기반이 되는 계정 이외의 계정으로 작성된 클러스터에 액세스하려면 계정에 로그인하여 새 API 키를 생성해야 합니다. </li><li><strong>일회성 패스코드 사용: </strong> 일회성 패스코드를 사용하여 {{site.data.keyword.Bluemix_notm}}에 인증하는 경우 일회성 패스코드에는 웹 브라우저와의 수동 상호작용이 필요하므로 IAM 토큰의 작성을 완전히 자동화할 수 없습니다. IAM 토큰의 작성을 완전히 자동화하려면 대신 {{site.data.keyword.Bluemix_notm}} API 키를 작성해야 합니다. </ul></td>
</tr>
</tbody>
</table>

1.  IAM(Identity and Access Management) 액세스 토큰을 작성하십시오. 요청에 포함되는 본문 정보는 사용하는 {{site.data.keyword.Bluemix_notm}} 인증 방법에 따라 다릅니다. 다음 값을 대체하십시오.
  - <em>&lt;my_username&gt;</em>:  {{site.data.keyword.Bluemix_notm}} 사용자 이름.
  - _&lt;my_password&gt;_: {{site.data.keyword.Bluemix_notm}} 비밀번호.
  - _&lt;my_api_key&gt;_: {{site.data.keyword.Bluemix_notm}} API 키
  - _&lt;my_passcode&gt;_: {{site.data.keyword.Bluemix_notm}} 일회성 패스코드. `bx login --sso`를 실행하고 CLI 출력의 지시사항에 따라 웹 브라우저를 사용하여 일회성 패스코드를 검색하십시오.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    예:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    {{site.data.keyword.Bluemix_notm}} 지역을 지정하려면 [API 엔드포인트에서 사용되는 지역 약어를 검토](cs_regions.html#bluemix_regions)하십시오.

    <table summary-"Input parameters to get tokens">
    <thead>
        <th>입력 매개변수</th>
        <th>값</th>
    </thead>
    <tbody>
    <tr>
    <td>헤더</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>권한: Basic Yng6Yng=<p><b>참고</b>: 사용자 이름 **bx** 및 비밀번호 **bx**에 대한 URL 인코딩 권한 Yng6Yng=가 제공됩니다.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 사용자 이름 및 비밀번호에 대한 본문</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>username: <em>&lt;my_username&gt;</em></li>
    <li>password: <em>&lt;my_password&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>참고</b>: 지정된 값이 없는 uaa_client_secret 키를 추가하십시오.</p></td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} API 키에 대한 본문</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>apikey: <em>&lt;my_api_key&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>참고</b>: 지정된 값이 없는 uaa_client_secret 키를 추가하십시오.</p></td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 일회성 패스코드에 대한 본문</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>passcode: <em>&lt;my_passcode&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>참고</b>: 지정된 값이 없는 uaa_client_secret 키를 추가하십시오.</p></td>
    </tr>
    </tbody>
    </table>

    API 출력 예제:

    ```
    {
    "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    API 출력의 **access_token** 필드에서 IAM 토큰을 찾을 수 있습니다. 다음 단계에서 추가 헤더 정보를 검색할 수 있도록 IAM 토큰을 기록해 두십시오.

2.  클러스터가 작성된 {{site.data.keyword.Bluemix_notm}} 계정의 ID를 검색하십시오. _&lt;iam_token&gt;_을 이전 단계에서 검색한 IAM 토큰으로 대체하십시오.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: codeblock}

    <table summary="{{site.data.keyword.Bluemix_notm}} 계정 ID를 가져오는 입력 매개변수">
    <thead>
  	<th>입력 매개변수</th>
  	<th>값</th>
    </thead>
    <tbody>
  	<tr>
  		<td>헤더</td>
  		<td><ul><li>Content-Type: application/json</li>
      <li>권한: bearer &lt;iam_token&gt;</li>
      <li>승인: application/json</li></ul></td>
  	</tr>
    </tbody>
    </table>

    API 출력 예제:

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
            "guid": "<my_account_id>",
            "url": "/v1/accounts/<my_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    API 출력의 **resources/metadata/guid** 필드에서 {{site.data.keyword.Bluemix_notm}} 계정의 ID를 찾을 수 있습니다.

3.  사용자의 {{site.data.keyword.Bluemix_notm}} 신임 정보 및 클러스터가 작성된 계정 ID가 포함된 새 IAM 토큰을 작성하십시오. _&lt;my_account_id&gt;_를 이전 단계에서 검색한 {{site.data.keyword.Bluemix_notm}} 계정의 ID로 대체하십시오.

    **참고:** {{site.data.keyword.Bluemix_notm}} API 키를 사용 중인 경우 API 키가 작성된 {{site.data.keyword.Bluemix_notm}} 계정 ID를 사용해야 합니다. 다른 계정에서 클러스터에 액세스하려면 이 계정에 로그인하고 이 계정을 기반으로 하는 {{site.data.keyword.Bluemix_notm}} API 키를 작성하십시오.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    예:
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    {{site.data.keyword.Bluemix_notm}} 지역을 지정하려면 [API 엔드포인트에서 사용되는 지역 약어를 검토](cs_regions.html#bluemix_regions)하십시오.

    <table summary-"Input parameters to get tokens">
    <thead>
        <th>입력 매개변수</th>
        <th>값</th>
    </thead>
    <tbody>
    <tr>
    <td>헤더</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>권한: Basic Yng6Yng=<p><b>참고</b>: 사용자 이름 **bx** 및 비밀번호 **bx**에 대한 URL 인코딩 권한 Yng6Yng=가 제공됩니다.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 사용자 이름 및 비밀번호에 대한 본문</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>username: <em>&lt;my_username&gt;</em></li>
    <li>password: <em>&lt;my_password&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>참고</b>: 지정된 값이 없는 uaa_client_secret 키를 추가하십시오.</p></td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} API 키에 대한 본문</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>apikey: <em>&lt;my_api_key&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>참고</b>: 지정된 값이 없는 uaa_client_secret 키를 추가하십시오.</p></td>
    </tr>
    <tr>
    <td>{{site.data.keyword.Bluemix_notm}} 일회성 패스코드에 대한 본문</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>passcode: <em>&lt;my_passcode&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>참고<b>: 지정된 값이 없는 uaa_client_secret 키를 추가하십시오.</p></td>
    </tr>
    </tbody>
    </table>

    API 출력 예제:

    ```
    {
      "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    **access_token**에서 IAM 토큰을 찾을 수 있고 **refresh_token**에서 IAM 새로 고치기 토큰을 찾을 수 있습니다.

4.  계정의 모든 Kubernetes 클러스터를 나열하십시오. 사용자의 헤더 정보를 빌드하기 위해 이전 단계에서 검색한 정보를 사용하십시오.

        ```
        GET https://containers.bluemix.net/v1/clusters
        ```
        {: codeblock}

        <table summary="API와 작동하는 입력 매개변수">
        <thead>
        <th>입력 매개변수</th>
        <th>값</th>
        </thead>
        <tbody>
        <tr>
        <td>헤더</td>
        <td><ul><li>권한: bearer <em>&lt;iam_token&gt;</em></li>
        <li>X-Auth-Refresh-Token: <em>&lt;refresh_token&gt;</em></li></ul></td>
        </tr>
        </tbody>
        </table>

5.  지원되는 API 목록은 [{{site.data.keyword.containershort_notm}} API 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://containers.bluemix.net/swagger-api)을 검토하십시오.

<br />


## IAM 액세스 토큰 새로 고치기
{: #cs_api_refresh}

API를 통해 발행된 모든 IAM(Identity and Access Management) 액세스 토큰은 한 시간 후에 만료됩니다. {{site.data.keyword.containershort_notm}} API에 대한 액세스가 보장되도록 사용자는 정기적으로 액세스 토큰을 새로 고쳐야 합니다.
{:shortdesc}

시작하기 전에 새 액세스 토큰을 요청하는 데 사용할 수 있는 IAM 새로 고치기 토큰이 있는지 확인하십시오. 새로 고치기 토큰이 없으면 [{{site.data.keyword.containershort_notm}} API로 클러스터 작성 및 관리 프로세스 작동화](#cs_api)를 검토하여 액세스 토큰을 검색하십시오.

IAM 토큰을 새로 고치려면 다음 단계를 사용하십시오.

1.  새 IAM 액세스 토큰을 생성하십시오. _&lt;iam_refresh_token&gt;_을 {{site.data.keyword.Bluemix_notm}}에서 인증되었을 때 받은 IAM 새로 고치기 토큰으로 대체하십시오.

    ```
    POST https://iam.bluemix.net/identity/token
    ```
    {: codeblock}

    <table summary="새 IAM 토큰의 입력 매개변수">
    <thead>
    <th>입력 매개변수</th>
    <th>값</th>
    </thead>
    <tbody>
    <tr>
    <td>헤더</td>
    <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
    <li>권한: Basic Yng6Yng=<p><b>참고</b>: 사용자 이름 **bx** 및 비밀번호 **bx**에 대한 URL 인코딩 권한 Yng6Yng=가 제공됩니다.</p></li></ul></td>
    </tr>
    <tr>
    <td>본문</td>
    <td><ul><li>grant_type: refresh_token</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;account_id&gt;</em></li></ul><p><b>참고</b>: 지정된 값이 없는 uaa_client_secret 키를 추가하십시오.</p></td>
    </tr>
    </tbody>
    </table>

    API 출력 예제:

    ```
    {
      "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    **access_token**에서 IAM 토큰을 찾을 수 있고 API 출력의 **refresh_token** 필드에서 IAM 새로 고치기 토큰을 찾을 수 있습니다.

2.  이전 단계의 토큰을 사용하여 [{{site.data.keyword.containershort_notm}} API 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://us-south.containers.bluemix.net/swagger-api)에 대한 작업을 진행하십시오.
