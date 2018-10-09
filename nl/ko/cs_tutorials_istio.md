---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# 튜토리얼: {{site.data.keyword.containerlong_notm}}에 Istio 설치
{: #istio_tutorial}

[Istio ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/info/istio)는 {{site.data.keyword.containerlong}}에서 클라우드 플랫폼(예: Kubernetes)의 서비스를 연결, 보호, 제어하고 관찰하기 위한 오픈 플랫폼입니다. Istio를 사용하여 네트워크 트래픽 관리하고, 마이크로서비스에서 로드 밸런싱하고, 액세스 정책을 적용하고, 서비스 ID를 확인할 수 있습니다.
{:shortdesc}

이 튜토리얼에서는 BookInfo라는 간단한 모의 서점 앱을 위해 네 개의 마이크로서비스에 나란히 Istio를 설치하는 방법을 살펴봅니다. 마이크로서비스는 제품 웹 페이지, 책 세부사항, 검토 및 평가를 포함합니다. Istio가 설치된 {{site.data.keyword.containerlong}} 클러스터에 BookInfo의 마이크로서비스를 배치하는 경우, 각 마이크로서비스의 팟(Pod)에 Istio Envoy 사이드카 프록시를 삽입합니다.

## 목표

-   클러스터에 Istio Helm 차트를 배치합니다.
-   BookInfo 샘플 앱을 배치합니다.
-   평가 서비스의 세 버전을 통해 BookInfo 앱 배치 및 라운드 로빈을 확인합니다.

## 소요 시간

30분

## 대상

이 튜토리얼은 처음으로 Istio를 사용하는 소프트웨어 개발자와 네트워크 관리자를 대상으로 합니다.

## 전제조건

-  [IBM Cloud CLI, {{site.data.keyword.containerlong_notm}} 플러그인 및 Kubernetes CLI를 설치](cs_cli_install.html#cs_cli_install_steps)하십시오. Istio에는 Kubernetes 버전 1.9 이상이 필요합니다. 클러스터의 Kubernetes 버전과 일치하는 `kubectl` CLI 버전을 설치해야 합니다.
-  [Kubernetes 버전 1.9 이상을 실행 중인 클러스터를 작성](cs_clusters.html#clusters_cli)하거나 [기존 클러스터를 버전 1.9로 업데이트](cs_versions.html#cs_v19)하십시오. 
-  [CLI를 클러스터에 대상으로 지정](cs_cli_install.html#cs_cli_configure)하십시오.

## 학습 1: Istio 다운로드 및 설치
{: #istio_tutorial1}

Istio를 클러스터에 다운로드하고 설치하십시오.
{:shortdesc}

1. [IBM Istio Helm 차트 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm/ibm-istio)를 사용하여 Istio를 설치하십시오.
    1. [클러스터에서 Helm을 설정하고 IBM 저장소를 Helm 인스턴스에 추가](cs_integrations.html#helm)하십시오. 
    2.  **Helm 버전 2.9 이하에만 해당**: Istio의 사용자 정의 리소스 정의를 설치하십시오.
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. 클러스터에 Helm 차트를 설치하십시오.
        ```
        helm install ibm/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. 계속하기 전에 Prometheus용 팟(Pod)과 9개의 Istio 서비스용 팟(Pod)이 모두 완전히 배치되었는지 확인하십시오.
    ```
   kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

잘하셨습니다! Istio를 클러스터에 설치했습니다. 다음, BookInfo 샘플 앱을 클러스터에 배치하십시오.


## 학습 2: BookInfo 앱 배치
{: #istio_tutorial2}

BookInfo 샘플 앱의 마이크로서비스를 Kubernetes 클러스터에 배치하십시오.
{:shortdesc}

이러한 네 개의 마이크로서비스는 제품 웹 페이지, 책 세부사항, 검토(검토 마이크로서비스의 여러 버전으로) 및 평가를 포함합니다. BookInfo를 배치하는 경우 마이크로서비스 팟(Pod)이 배치되기 전에 Envoy 사이드카 프록시가 컨테이너로서 앱 마이크로서비스의 팟(Pod)에 삽입됩니다. Istio는 Envoy 프록시의 확장 버전을 사용하여 서비스 메쉬에서 모든 마이크로서비스에 대한 모든 인바운드 및 아웃바운드 트래픽을 중개합니다. Envoy에 대한 자세한 정보는 [Istio 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy)를 참조하십시오.

1. 필요한 BookInfo 파일이 포함된 Istio 패키지를 다운로드하십시오.
    1. [https://github.com/istio/istio/releases ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://github.com/istio/istio/releases)에서 Istio를 직접 다운로드하고 설치 파일의 압축의 풀거나 cURL을 사용하여 최신 버전을 가져오십시오.
       ```
   curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. 디렉토리를 Istio 파일 위치로 변경하십시오.
       ```
       cd <filepath>/istio-1.0
       ```
       {: pre}

    3. `istioctl` 클라이언트를 사용자의 PATH에 추가하십시오. 예를 들어, MacOS 또는 Linux 시스템에서 다음 명령을 실행하십시오.
        ```
       export PATH=$PWD/istio-1.0/bin:$PATH
        ```
        {: pre}

2. `istio-injection=enabled`로 `default` 네임스페이스의 레이블을 지정하십시오.
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. BookInfo 앱을 배치하십시오. 앱 마이크로서비스가 배치될 때 Envoy 사이드카도 각 마이크로서비스 팟(Pod)에 배치됩니다.

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. 마이크로서비스와 해당 팟(Pod)이 배치되었는지 확인하십시오.
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
            kubectl get pods
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

5. 앱 배치를 확인하려면 클러스터의 공인 주소를 가져오십시오.
    * 표준 클러스터:
        1. 공용 ingress IP에서 앱을 노출하려면 BookInfo 게이트웨이를 배치하십시오.
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

        2. ingress 호스트를 설정하십시오.
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        3. ingress 포트를 설정하십시오.
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        4. ingress 호스트 및 포트를 사용하는 `GATEWAY_URL` 환경 변수를 작성하십시오.

           ```
           export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
           ```
           {: pre}

    * 무료 클러스터:
        1. 클러스터에서 작업자 노드의 공인 IP 주소를 가져오십시오.
            ```
            ibmcloud ks workers <cluster_name_or_ID>
            ```
            {: pre}

        2. 작업자 노드의 공인 IP 주소를 사용하는 GATEWAY_URL 환경 변수를 작성하십시오.
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. `GATEWAY_URL` 변수의 curl을 수행하여 BookInfo 앱이 실행 중인지 확인하십시오. `200` 응답은 BookInfo 앱이 Istio에서 적절하게 실행 중임을 의미합니다.
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  브라우저에서 BookInfo 웹 페이지를 보십시오. 

    Mac OS 또는 Linux의 경우:
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Windows의 경우:
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

7. 페이지를 여러 번 새로 고쳐보십시오. 검토 섹션의 다른 버전은 빨간색 별, 검은색 별, 별 없음을 통해 라운드 로빈됩니다.

잘하셨습니다! Istio Envoy 사이드카로 BookInfo 샘플 앱을 배치했습니다. 그 다음에는 리소스를 정리하거나 튜토리얼을 계속 더 진행하여 Istio를 추가로 탐색할 수 있습니다.

## 정리
{: #istio_tutorial_cleanup}

Istio에 대한 작업을 완료했으며 [계속해서 탐색](#istio_tutorial_whatsnext)하지 않으려는 경우 클러스터에서 Istio 리소스를 정리할 수 있습니다.
{:shortdesc}

1. 클러스터에서 모든 BookInfo 서비스, 팟(Pod) 및 배치를 삭제하십시오.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. Istio Helm 배치를 설치 제거하십시오.
    ```
    helm del istio --purge
    ```
    {: pre}

3. **선택사항**: Helm 2.9 이하를 사용 중이며 Istio 사용자 정의 리소스 정의를 적용한 경우에는 이를 삭제하십시오.
    ```
    kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
    ```
    {: pre}

## 다음 단계
{: #istio_tutorial_whatsnext}

* Istio를 추가로 탐색하려면 [Istio 문서 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://istio.io/)에서 더 많은 안내서를 찾을 수 있습니다.
    * [Intelligent Routing ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://istio.io/docs/guides/intelligent-routing.html): 이 예제는 Istio의 트래픽 관리 기능을 사용하여 특정 BookInfo 버전의 검토 및 등급 마이크로서비스로 트래픽을 라우팅하는 방법을 보여줍니다.
    * [In-Depth Telemetry ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://istio.io/docs/guides/telemetry.html): 이 예에는 Istio Mixer와 Envoy 프록시를 사용하여 BookInfo의 전체 마이크로서비스에서 균일한 메트릭, 로그 및 추적을 얻는 방법이 포함되어 있습니다.
* [코그너티브 클래스: IBM Cloud Kubernetes 서비스 및 Istio로 마이크로서비스 시작하기![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/)를 수행하십시오. **참고**: 이 과정의 Istio 설치 섹션을 건너뛸 수 있습니다.
* Istio 서비스 메시를 시각화하려면 [Vistio ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) 사용의 이 블로그 포스트를 체크아웃하십시오.
