---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-26"

keywords: kubernetes, iks 

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# 네트워크 트래픽을 에지 작업자 노드로 제한
{: #edge}

{{site.data.keyword.containerlong}}에서 에지 작업자 노드는 외부에서 적은 수의 작업자 노드에 액세스할 수 있게 하고 네트워크 워크로드를 격리함으로써 Kubernetes 클러스터의 보안을 향상시킬 수 있습니다.
{:shortdesc}

이러한 작업자 노드가 네트워킹 전용으로 표시되는 경우 다른 워크로드는 작업자 노드의 CPU 또는 메모리를 이용할 수 없고 네트워킹을 방해할 수도 없습니다.

다중 구역 클러스터가 있으며 네트워크 트래픽을 에지 작업자 노드로 제한하려면, 로드 밸런서 또는 Ingress 팟(Pod)의 고가용성을 위해 각 구역에서 최소한 2개의 에지 작업자 노드가 사용으로 설정되어야 합니다. 구역당 최소한 2개의 작업자 노드가 있으며 클러스터의 모든 구역에 전개된 에지 노드 작업자 풀을 작성하십시오.
{: tip}

## 에지 노드로 작업자 노드에 레이블 지정
{: #edge_nodes}

`dedicated=edge` 레이블을 클러스터의 각 공용 VLAN에 있는 둘 이상의 작업자 노드에 추가하여 Ingress와 로드 밸런서가 해당 작업자 노드에만 배치되도록 하십시오.
{:shortdesc}

시작하기 전에:

1. 다음 [{{site.data.keyword.Bluemix_notm}} IAM 역할](/docs/containers?topic=containers-users#platform)을 보유하고 있는지 확인하십시오.
  * 클러스터에 대한 임의의 플랫폼 역할
  * 모든 네임스페이스에 대한 **작성자** 또는 **관리자** 서비스 역할
2. [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
3. 클러스터에 하나 이상의 공용 VLAN을 가지고 있는지 확인하십시오. 에지 작업자 노드는 사설 VLAN만 있는 클러스터에서는 사용할 수 없습니다.
4. 구역당 최소한 2개의 작업자가 있으며 클러스터의 모든 구역에 전개된 [새 작업자 풀](/docs/containers?topic=containers-clusters#add_pool)을 작성하십시오.

에지 노드로 작업자 노드에 레이블을 지정하려면 다음을 수행하십시오.

1. 에지 노드 작업자 풀의 작업자 노드를 나열하십시오. 노드를 식별하려면 **Private IP** 주소를 사용하십시오.

  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <edge_pool_name>
  ```
  {: pre}

2. `dedicated=edge`로 작업자 노드의 레이블을 지정하십시오. 작업자 노드가 `dedicated=edge`와 함께 표시되면 모든 후속 Ingress 및 로드 밸런서가 에지 작업자 노드에 배치됩니다.

  ```
  kubectl label nodes <node1_IP> <node2_IP> dedicated=edge
  ```
  {: pre}

3. 클러스터의 모든 기존 로드 밸런서 및 Ingress 애플리케이션 로드 밸런서(ALB)를 검색하십시오.

  ```
  kubectl get services --all-namespaces
  ```
  {: pre}

  출력에서 **TYPE**이 **LoadBalancer**인 서비스를 찾으십시오. 각 로드 밸런서 서비스의 **NAMESPACE** 및 **NAME**을 기록하십시오. 예를 들어, 다음 출력에는 3개의 로드 밸런서 서비스(`default` 네임스페이스의 `webserver-lb` 로드 밸런서, `kube-system` 네임스페이스의 Ingress ALB `public-crdf253b6025d64944ab99ed63bb4567b6-alb1` 및 `public-crdf253b6025d64944ab99ed63bb4567b6-alb2`)가 있습니다.

  ```
  NAMESPACE     NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
  default       kubernetes                                       ClusterIP      172.21.0.1       <none>          443/TCP                      1h
  default       webserver-lb                                     LoadBalancer   172.21.190.18    169.46.17.2     80:30597/TCP                 10m
  kube-system   heapster                                         ClusterIP      172.21.101.189   <none>          80/TCP                       1h
  kube-system   kube-dns                                         ClusterIP      172.21.0.10      <none>          53/UDP,53/TCP                1h
  kube-system   kubernetes-dashboard                             ClusterIP      172.21.153.239   <none>          443/TCP                      1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb1   LoadBalancer   172.21.84.248    169.48.228.78   80:30286/TCP,443:31363/TCP   1h
  kube-system   public-crdf253b6025d64944ab99ed63bb4567b6-alb2   LoadBalancer   172.21.229.73    169.46.17.6     80:31104/TCP,443:31138/TCP   57m
  ```
  {: screen}

4. 이전 단계의 출력을 사용하여, 각 로드 밸런서 및 Ingress ALB에 대해 다음 명령을 실행하십시오. 이 명령은 로드 밸런서 또는 Ingress ALB를 에지 작업자 노드로 다시 배치합니다. 공용 로드 밸런서 또는 ALB만 다시 배치해야 합니다.

  ```
  kubectl get service -n <namespace> <service_name> -o yaml | kubectl apply -f -
  ```
  {: pre}

  출력 예:

  ```
  service "my_loadbalancer" configured
  ```
  {: screen}

`dedicated=edge`로 작업자 노드의 레이블을 지정했으며 기존 모든 로드 밸런서와 Ingress를 에지 작업자 노드에 다시 배치했습니다. 다음으로 다른 [워크로드가 에지 작업자 노드에서 실행](#edge_workloads)되지 않도록 하고 [작업자 노드에서 NodePort에 대한 인바운드 트래픽을 차단](/docs/containers?topic=containers-network_policies#block_ingress)하십시오.

<br />


## 워크로드가 에지 작업자 노드에서 실행되지 않도록 금지
{: #edge_workloads}

에지 작업자 노드의 이점은 네트워킹 서비스만 실행하도록 이러한 작업자 노드를 지정할 수 있다는 것입니다.
{:shortdesc}

`dedicated=edge` 결함 허용(toleration)을 사용하면 모든 로드 밸런서와 Ingress 서비스가 레이블 지정된 작업자 노드에만 배치됩니다. 하지만 다른 워크로드가 에지 작업자 노드에서 실행되지 않고 작업자 노드 리소스를 이용하지 못하도록 하려면 [Kubernetes 오염(taint) ![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/)을 사용해야 합니다.

시작하기 전에:
- 모든 네임스페이스에 대해 [**관리자** {{site.data.keyword.Bluemix_notm}} IAM 서비스 역햘](/docs/containers?topic=containers-users#platform)이 있는지 확인하십시오.
- [계정에 로그인하십시오. 적절한 지역을 대상으로 지정하고, 해당되는 경우에는 리소스 그룹도 지정하십시오. 클러스터의 컨텍스트를 설정하십시오](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

워크로드가 에지 작업자 노드에서 실행되지 않도록 하려면 다음을 수행하십시오.

1. `dedicated=edge` 레이블이 있는 모든 작업자 노드를 나열하십시오.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. 팟(Pod)이 작업자 노드에서 실행되지 않도록 하고 작업자 노드에서 `dedicated=edge` 레이블이 없는 팟(Pod)을 제거하는 오염을 각 작업자 노드에 적용하십시오. 제거된 팟(Pod)은 용량이 있는 다른 작업자 노드에 다시 배치됩니다.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```
  {: pre}
이제 `dedicated=edge` 결함 허용을 사용하는 팟(Pod)만 에지 작업자 노드에 배치됩니다.

3. [로드 밸런서 서비스에 대해 소스 IP 보존을 사용으로 설정![외부 링크 아이콘](../icons/launch-glyph.svg "외부 링크 아이콘")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer)하도록 선택한 경우에는 [에지 노드 친화성을 앱 팟(Pod)에 추가](/docs/containers?topic=containers-loadbalancer#lb_edge_nodes)하여 앱 팟(Pod)이 에지 작업자 노드에 스케줄링되도록 하십시오. 수신 요청을 받도록 앱 팟(Pod)이 에지 노드에 스케줄되어야 합니다.

4. 오염을 제거하려면 다음 명령을 실행하십시오.
    ```
    kubectl taint node <node_name> dedicated:NoSchedule- dedicated:NoExecute-
    ```
    {: pre}
