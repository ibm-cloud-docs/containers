---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 성능 튜닝
{: #kernel}

특정 성능 최적화 요구사항이 있는 경우, {{site.data.keyword.containerlong}}의 작업자 노드와 팟(Pod) 네트워크 네임스페이스에서 Linux 커널 `sysctl` 매개변수의 기본 설정을 변경할 수 있습니다.
{: shortdesc}

작업자 노드는 최적화된 커널 성능으로 자동 프로비저닝되지만 클러스터에 사용자 정의 Kubernetes `DaemonSet` 오브젝트를 적용하여 기본 설정을 변경할 수 있습니다. DaemonSet은 모든 기존 작업자 노드의 설정을 변경하며 클러스터에서 프로비저닝되는 새 작업자 노드에 해당 설정을 적용합니다. 어떤 팟(Pod)도 영향을 받지 않습니다.

앱 팟(Pod)의 커널 설정을 최적화하기 위해 각 배치마다 `pod/ds/rs/deployment` YAML에 initContainer를 삽입할 수 있습니다. initContainer는 해당 성능의 최적화를 원하는 팟(Pod) 네트워크 네임스페이스에 있는 각 앱 배치에 추가됩니다.

예를 들어, 다음 절의 샘플은 `net.core.somaxconn` 설정을 통해 환경에서 허용되는 기본 최대 연결 수를 변경하고 `net.ipv4.ip_local_port_range` 설정을 통해 임시 포트 범위를 변경합니다.

**경고**: 기본 커널 매개변수 설정 변경을 선택하면 사용자가 직접 위험을 감수해야 합니다. 사용자 환경의 변경된 설정으로 인해 발생하는 잠재적 중단에 대해, 그리고 변경된 설정에 대한 테스트의 실행에 대해 사용자가 직접 책임을 져야 합니다.

## 작업자 노드 성능 최적화
{: #worker}

작업자 노드 호스트의 커널 매개변수를 변경하려면 [DaemonSet ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)을 적용하십시오. 

**참고**: 권한 부여된 샘플 initContainer를 실행하려면 [관리자 액세스 역할](cs_users.html#access_policies)이 있어야 합니다. 배치를 위한 컨테이너가 초기화되면 권한이 삭제됩니다.

1. 이름이 `worker-node-kernel-settings.yaml`인 파일에 다음 DaemonSet을 저장하십시오. `spec.template.spec.initContainers` 섹션에서 튜닝하고자 하는 `sysctl` 매개변수의 필드와 값을 추가하십시오. 이 DaemonSet 예는 `net.core.somaxconn` 및 `net.ipv4.ip_local_port_range` 매개변수의 값을 변경합니다.
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - command:
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. 작업자 노드에 DaemonSet을 적용하십시오. 변경사항은 즉시 적용됩니다.
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

{{site.data.keyword.containerlong_notm}}에서 설정한 기본값으로 작업자 노드의 `sysctl` 매개변수를 되돌리려면 다음을 수행하십시오.

1. DaemonSet을 삭제하십시오. 사용자 정의 설정을 적용한 initContainers가 제거됩니다.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [클러스터의 모든 작업자 노드를 재부팅](cs_cli_reference.html#cs_worker_reboot)하십시오. 작업자 노드가 기본값이 적용되어 다시 온라인 상태가 됩니다.

<br />


## 팟(Pod) 성능 최적화
{: #pod}

특정 워크로드 요구사항이 있는 경우에는 [initContainer ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) 패치를 적용하여 앱 팟(Pod)에 대한 커널 매개변수를 변경할 수 있습니다.
{: shortdesc}

**참고**: 권한 부여된 샘플 initContainer를 실행하려면 [관리자 액세스 역할](cs_users.html#access_policies)이 있어야 합니다. 배치를 위한 컨테이너가 초기화되면 권한이 삭제됩니다.

1. 이름이 `pod-patch.yaml`인 파일에 다음의 initContainer 패치를 저장하고 튜닝할 `sysctl` 매개변수의 필드와 값을 추가하십시오. 이 예제 initContainer는 `net.core.somaxconn` 및 `net.ipv4.ip_local_port_range` 매개변수의 값을 변경합니다.
    ```
    spec:
      template:
        spec:
          initContainers:
          - command:
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. 각 배치를 패치하십시오.
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. 커널 설정에서 `net.core.somaxconn` 값을 변경한 경우에는 대부분의 앱이 업데이트된 값을 자동으로 사용할 수 있습니다. 그러나 일부 앱에서는 커널 값과 일치하도록 앱 코드의 대응되는 값을 수동으로 변경해야 할 수도 있습니다. 예를 들어, NGINX 앱이 실행 중인 팟(Pod)의 성능을 튜닝 중인 경우에는 일치시킬 NGINX 앱 코드의 `backlog` 필드 값을 변경해야 합니다. 자세한 정보는 이 [NGINX 블로그 게시물 ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://www.nginx.com/blog/tuning-nginx/)을 참조하십시오.
