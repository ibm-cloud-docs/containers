---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# {{site.data.keyword.containerlong_notm}} 的熱門主題
{: #cs_popular_topics}

掌握 {{site.data.keyword.containerlong}} 中發生的情況。瞭解要探索的新特性、要試用的訣竅，或其他開發人員目前發現很有用的一些熱門主題。
{:shortdesc}

## 2018 年 12 月的熱門主題
{: #dec18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 12 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>12 月 6 日</td>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>取得應用程式效能及性能的作業可見性，方法為將 Sysdig 作為協力廠商服務部署至工作者節點，以將度量轉遞至 {{site.data.keyword.monitoringlong}}。如需相關資訊，請參閱[分析在 Kubernetes 叢集裡部署之應用程式的度量](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster)。**附註**：如果您使用 {{site.data.keyword.mon_full_notm}} 與執行 Kubernets 1.11 版或更新版本的叢集搭配，則不會收集所有容器度量，因為 Syslig 目前不支援 `containerd`。</td>
</tr>
</tbody></table>

## 2018 年 11 月的熱門主題
{: #nov18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 11 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>11 月 29 日</td>
<td>[清奈現在為可用區域](cs_regions.html)</td>
<td>歡迎印度清奈成為亞太地區北部地區中的叢集新區域。如果您有防火牆，務必針對此區域以及您叢集所在地區內的其他區域[開啟防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>11 月 27 日</td>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>將日誌管理功能新增至叢集，方法為將 LogDNA 作為協力廠商服務部署至工作者節點，以管理來自 Pod 容器的日誌。如需相關資訊，請參閱[使用 {{site.data.keyword.loganalysisfull_notm}} 搭配 LogDNA 來管理 Kubernetes 叢集日誌](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube)。</td>
</tr>
<tr>
<td>11 月 7 日</td>
<td>負載平衡器 2.0（測試版）</td>
<td>現在，您可以在[負載平衡器 1.0 或 2.0](cs_loadbalancer.html#planning_ipvs) 之間進行選擇，以安全地將叢集應用程式公開給大眾使用。</td>
</tr>
<tr>
<td>11 月 7 日</td>
<td>提供 Kubernetes 1.12 版</td>
<td>現在，您可以更新或建立執行 [Kubernetes 1.12 版](cs_versions.html#cs_v112)的叢集！依預設，1.12 叢集隨附高可用性 Kibernetes 主節點。</td>
</tr>
<tr>
<td>11 月 7 日</td>
<td>執行 Kubernetes 1.10 版之叢集裡的高可用性主節點</td>
<td>高可用性主節點適用於執行 Kubernetes 1.10 版的叢集！在 1.11 叢集的先前項目中所述的所有好處都適用於 1.10 叢集，您必須採取的[準備步驟](cs_versions.html#110_ha-masters)也同時適用。</td>
</tr>
<tr>
<td>11 月 1 日</td>
<td>執行 Kubernetes 1.11 版之叢集裡的高可用性主節點</td>
<td>在單一區域中，您的主節點具有高可用性，且會在個別實體主機上包含 Kubernetes API 伺服器、etcd、排程器及控制器管理程式的抄本，來防範在叢集更新這類期間發生運作中斷。如果您的叢集是在具有多區域功能的區域中，則您的高可用性主節點也會分散在各個區域之中，以協助防範區域失敗。<br>如需您必須採取的動作，請參閱[更新為高可用性叢集主節點](cs_versions.html#ha-masters)。這些準備動作適用下列情況：<ul>
<li>如果您具有防火牆或自訂 Calico 網路原則。</li>
<li>如果您是在工作者節點上使用主機埠 `2040` 或 `2041`。</li>
<li>如果您已使用叢集主節點 IP 位址，對主節點進行叢集內存取。</li>
<li>如果您具有呼叫 Calico API 或 CLI (`calictl`) 的自動化，例如，建立 Calico 原則。</li>
<li>如果您使用 Kubernetes 或 Calico 網路原則，來控制對主節點的 Pod Egress 存取。</li></ul></td>
</tr>
</tbody></table>

## 2018 年 10 月的熱門主題
{: #oct18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 10 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>10 月 25 日</td>
<td>[米蘭現在為可用區域](cs_regions.html)</td>
<td>義大利米蘭已成為歐盟中部地區中付費叢集的新區域。先前，米蘭只適用於免費叢集。如果您有防火牆，務必針對此區域以及您叢集所在地區內的其他區域[開啟防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>10 月 22 日</td>
<td>[新的倫敦多區域位置 `lon05`](cs_regions.html#zones)</td>
<td>倫敦多區域都會城市會將 `lon02` 區域取代為新的 `lon05` 區域（即基礎架構資源比 `lon02` 還要多的區域）。建立具有 `lon05` 的新多區域叢集。支援具有 `lon02` 的現有叢集，但新的多區域叢集必須改用 `lon05`。</td>
</tr>
<tr>
<td>10 月 5 日</td>
<td>與 {{site.data.keyword.keymanagementservicefull}} 整合</td>
<td>您可以[啟用 {{site.data.keyword.keymanagementserviceshort}}（測試版）](cs_encrypt.html#keyprotect)，來加密叢集裡的 Kubernetes 密碼。</td>
</tr>
<tr>
<td>10 月 4 日</td>
<td>[{{site.data.keyword.registrylong}} 現在會與 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 整合](/docs/services/Registry/iam.html#iam)</td>
<td>您可以使用 {{site.data.keyword.Bluemix_notm}} IAM 來控制對登錄資源（例如取回、推送及建置映像檔）的存取權。當您建立叢集時，也會建立登錄記號，讓叢集可以使用您的登錄。因此，您需要帳戶層次登錄**管理者**平台管理角色，才能建立叢集。若要啟用登錄帳戶的 {{site.data.keyword.Bluemix_notm}} IAM，請參閱[啟用現有使用者的原則強制執行](/docs/services/Registry/registry_users.html#existing_users)。</td>
</tr>
<tr>
<td>10 月 1 日</td>
<td>[資源群組](cs_users.html#resource_groups)</td>
<td>您可以使用資源群組，將 {{site.data.keyword.Bluemix_notm}} 資源區隔為管線、部門或其他分組，以協助指派存取權及計量用量。現在，{{site.data.keyword.containerlong_notm}} 支援在 `default` 群組或您建立的任何其他資源群組中建立叢集！</td>
</tr>
</tbody></table>

## 2018 年 9 月的熱門主題
{: #sept18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 9 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>9 月 25 日</td>
<td>[有新的區域可用](cs_regions.html)</td>
<td>現在，您甚至有更多的位置選項可以部署應用程式！
<ul><li>聖荷西已成為美國南部地區中的兩個新區域：`sjc03` 及 `sjc04`。如果您有防火牆，務必針對此區域以及您叢集所在地區內的其他區域[開啟防火牆埠](cs_firewall.html#firewall)。</li>
<li>使用兩個新的 `tok04` 及 `tok05` 區域，您現在可以在亞太地區北部地區的東京中[建立多區域叢集](cs_clusters_planning.html#multizone)。</li></ul></td>
</tr>
<tr>
<td>05 年 9 月</td>
<td>[奧斯陸現在為可用區域](cs_regions.html)</td>
<td>挪威奧斯陸已成為歐盟中部地區的新區域。如果您有防火牆，務必針對此區域以及您叢集所在地區內的其他區域[開啟防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
</tbody></table>

## 2018 年 8 月的熱門主題
{: #aug18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 8 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>8 月 31 日</td>
<td>{{site.data.keyword.cos_full_notm}} 現在與 {{site.data.keyword.containerlong}} 整合</td>
<td>使用 Kubernetes 原生持續性磁區要求 (PVC) 來將 {{site.data.keyword.cos_full_notm}} 佈建給叢集。{{site.data.keyword.cos_full_notm}} 最適用於讀取密集工作量，以及您是否要將資料儲存在多區域叢集裡的多個區域中。從[建立 {{site.data.keyword.cos_full_notm}} 服務實例](cs_storage_cos.html#create_cos_service)及在叢集上[安裝 {{site.data.keyword.cos_full_notm}} 外掛程式](cs_storage_cos.html#install_cos)開始。</br></br>不確定您適用哪一個儲存空間解決方案？[在這裡](cs_storage_planning.html#choose_storage_solution)開始分析您的資料，並為您的資料選擇適當的儲存空間解決方案。</td>
</tr>
<tr>
<td>8 月 14 日</td>
<td>將叢集更新為 Kubernetes 1.11 版以指派 Pod 優先順序</td>
<td>在將叢集更新為 [Kubernetes 1.11 版](cs_versions.html#cs_v111)之後，您可以充分運用新功能，例如，使用 `containerd` 來增加容器運行環境效能或[指派 Pod 優先順序](cs_pod_priority.html#pod_priority)。</td>
</tr>
</tbody></table>

## 2018 年 7 月的熱門主題
{: #july18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 7 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>7 月 30 日</td>
<td>[自行準備 Ingress 控制器](cs_ingress.html#user_managed)</td>
<td>您的叢集 Ingress 控制器有極特別的安全或其他自訂需求嗎？如果是，您可能要執行自己的 Ingress 控制器，而非預設值。</td>
</tr>
<tr>
<td>7 月 10 日</td>
<td>多區域叢集簡介</td>
<td>要改善叢集可用性嗎？現在，您可以跨越精選都會區域中跨多個區域的叢集。如需相關資訊，請參閱[在 {{site.data.keyword.containerlong_notm}} 中建立多區域叢集](cs_clusters_planning.html#multizone)。</td>
</tr>
</tbody></table>

## 2018 年 6 月的熱門主題
{: #june18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 6 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>6 月 13 日</td>
<td>`bx` CLI 指令名稱會變更為 `ic` CLI</td>
<td>下載最新版本的 {{site.data.keyword.Bluemix_notm}} CLI 後，您現在即可使用 `ic` 字首來執行指令，而非 `bx`。例如，執行 `ibmcloud ks clusters` 來列出叢集。</td>
</tr>
<tr>
<td>6 月 12 日</td>
<td>[Pod 安全原則](cs_psp.html)</td>
<td>對於執行 Kubernetes 1.10.3 或更新版本的叢集，您可以配置 Pod 安全原則來授權誰可以在 {{site.data.keyword.containerlong_notm}} 中建立及更新 Pod。</td>
</tr>
<tr>
<td>6 月 6 日</td>
<td>[IBM 提供的 Ingress 萬用字元子網域的 TLS 支援](cs_ingress.html#wildcard_tls)</td>
<td>對於在 2018 年 6 月 6 日或之後建立的叢集，IBM 提供的 Ingress 子網域 TLS 憑證現在是萬用字元憑證，可用於已登錄的萬用字元子網域。對於在 2018 年 6 月 6 日之前建立的叢集，更新現行 TLS 憑證時，會將 TLS 憑證更新為萬用字元憑證。</td>
</tr>
</tbody></table>

## 2018 年 5 月的熱門主題
{: #may18}


<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 5 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>5 月 24 日</td>
<td>[新的 Ingress 子網域格式](cs_ingress.html)</td>
<td>在 5 月 24 日之後建立的叢集會獲指派新格式的子網域，即 <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>。使用 Ingress 公開您的應用程式時，您可以使用新的子網域，從網際網路存取您的應用程式。</td>
</tr>
<tr>
<td>5 月 14 日</td>
<td>[更新：在全球 GPU 裸機上部署工作負載](cs_app.html#gpu_app)</td>
<td>如果您的叢集裡有[裸機圖形處理裝置 (GPU) 機型](cs_clusters_planning.html#shared_dedicated_node)，則可以排定數學運算密集的應用程式。GPU 工作者節點可以同時跨 CPU 及 GPU 處理應用程式的工作負載，以增進效能。</td>
</tr>
<tr>
<td>5 月 3 日</td>
<td>[Container Image Security Enforcement（測試版）](/docs/services/Registry/registry_security_enforce.html#security_enforce)</td>
<td>您的團隊是否需要一些額外的協助，才能知道要在應用程式容器中取回哪個映像檔？在部署容器映像檔之前，請試用 Container Image Security Enforcement 測試版以驗證它們。可供執行 Kubernetes 1.9 或更新版本的叢集使用。</td>
</tr>
<tr>
<td>5 月 1 日</td>
<td>[從主控台部署 Kubernetes 儀表板](cs_app.html#cli_dashboard)</td>
<td>您是否曾想要利用按一下滑鼠來存取 Kubernetes 儀表板？請查看 {{site.data.keyword.Bluemix_notm}} 主控台中的 **Kubernetes 儀表板**按鈕。</td>
</tr>
</tbody></table>




## 2018 年 4 月的熱門主題
{: #apr18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 4 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>4 月 17 日</td>
<td>{{site.data.keyword.Bluemix_notm}} Block Storage</td>
<td>安裝 {{site.data.keyword.Bluemix_notm}} Block Storage [外掛程式](cs_storage_block.html#install_block)，以在區塊儲存空間中儲存持續資料。然後，您可以針對叢集[建立新的](cs_storage_block.html#add_block)或[使用現有的](cs_storage_block.html#existing_block)區塊儲存空間。</td>
</tr>
<tr>
<td>4 月 13 日</td>
<td>[將 Cloud Foundry 應用程式移轉至叢集的新指導教學](cs_tutorials_cf.html#cf_tutorial)</td>
<td>您有 Cloud Foundry 應用程式嗎？學習如何將該應用程式中的相同程式碼部署至 Kubernetes 叢集裡執行的容器。</td>
</tr>
<tr>
<td>4 月 5 日</td>
<td>[過濾日誌](cs_health.html#filter-logs)</td>
<td>過濾出特定日誌，不進行轉遞。可以針對特定的名稱空間、容器名稱、記載層次及訊息字串來濾出日誌。</td>
</tr>
</tbody></table>

## 2018 年 3 月的熱門主題
{: #mar18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 3 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>3 月 16 日</td>
<td>[使用授信運算佈建裸機叢集](cs_clusters_planning.html#shared_dedicated_node)</td>
<td>建立執行 [Kubernetes 1.9 版](cs_versions.html#cs_v19)或更新版本的裸機叢集，並啟用「授信運算」來驗證工作者節點是否遭到竄改。</td>
</tr>
<tr>
<td>3 月 14 日</td>
<td>[安全登入 {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>要求使用者登入，以加強在 {{site.data.keyword.containerlong_notm}} 中執行的應用程式。</td>
</tr>
<tr>
<td>3 月 13 日</td>
<td>[聖保羅現在為可用區域](cs_regions.html)</td>
<td>巴西聖保羅已成為美國南部地區的新區域。如果您有防火牆，務必針對此區域以及您叢集所在地區內的其他區域[開啟防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>3 月 12 日</td>
<td>[要使用「試用」帳戶加入 {{site.data.keyword.Bluemix_notm}} 嗎？歡迎試用免費的 Kubernetes 叢集！](container_index.html#clusters)</td>
<td>使用「試用」[{{site.data.keyword.Bluemix_notm}} 帳戶](https://console.bluemix.net/registration/)，您可以部署一個免費使用 30 天的叢集，來測試 Kubernetes 功能。</td>
</tr>
</tbody></table>

## 2018 年 2 月的熱門主題
{: #feb18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 2 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>2 月 27 日</td>
<td>工作者節點的硬體虛擬機器 (HVM) 映像檔</td>
<td>增加 HVM 映像檔工作負載的 I/O 效能。使用 `ibmcloud ks worker-reload` [指令](cs_cli_reference.html#cs_worker_reload)或 `ibmcloud ks worker-update` [指令](cs_cli_reference.html#cs_worker_update)，在每個現有的工作者節點上啟動。</td>
</tr>
<tr>
<td>2 月 26 日</td>
<td>[KubeDNS 自動調整](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS 現在會隨著叢集成長而調整。您可以使用下列指令來調整其調整量：`kubectl -n kube-system edit cm kube-dns-autoscaler`。</td>
</tr>
<tr>
<td>2 月 23 日</td>
<td>檢視 Web 主控台中的[記載](cs_health.html#view_logs)及[度量值](cs_health.html#view_metrics)</td>
<td>使用改良的 Web 使用者介面，輕鬆檢視叢集和其元件的日誌及度量值資料。請參閱叢集詳細資料頁面來進行存取。</td>
</tr>
<tr>
<td>2 月 20 日</td>
<td>已加密的映像檔及[已簽署的信任內容](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>在 {{site.data.keyword.registryshort_notm}} 中，您可以簽署及加密映像檔，以確保您在登錄名稱空間中儲存之映像檔的完整性。只使用信任的內容來執行您的容器實例。</td>
</tr>
<tr>
<td>2 月 19 日</td>
<td>[設定 strongSwan IPSec VPN](cs_vpn.html#vpn-setup)</td>
<td>快速部署 strongSwan IPSec VPN Helm 圖表，以將 {{site.data.keyword.containerlong_notm}} 叢集安全地連接至內部部署的資料中心，而不使用 Virtual Router Appliance。</td>
</tr>
<tr>
<td>2 月 14 日</td>
<td>[首爾現在為可用區域](cs_regions.html)</td>
<td>剛好來得及趕上奧林匹克運動會，將 Kubernetes 叢集部署至位於亞太地區北部的首爾。如果您有防火牆，務必針對此區域以及您叢集所在地區內的其他區域[開啟防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>2 月 8 日</td>
<td>[更新 Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>更新至 Kubernetes 1.9 之前，請先檢閱對叢集所做的變更。</td>
</tr>
</tbody></table>

## 2018 年 1 月的熱門主題
{: #jan18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 1 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<td>1 月 25 日</td>
<td>[現已推出廣域登錄](../services/Registry/registry_overview.html#registry_regions)</td>
<td>透過 {{site.data.keyword.registryshort_notm}}，您可以使用廣域 `registry.bluemix.net` 來取回 IBM 提供的公用映像檔。</td>
</tr>
<tr>
<td>1 月 23 日</td>
<td>[新加坡及加拿大蒙特婁現在為可用區域](cs_regions.html)</td>
<td>新加坡及蒙特婁是位於 {{site.data.keyword.containerlong_notm}} 亞太地區北部及美國東部地區的可用區域。如果您有防火牆，務必針對這些區域以及您叢集所在地區內的其他區域[開啟防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>1 月 8 日</td>
<td>[已加強的可用特性](cs_cli_reference.html#cs_machine_types)</td>
<td>系列 2 虛擬機型包括本端 SSD 儲存空間及磁碟加密。[將工作負載移至](cs_cluster_update.html#machine_type)這些特性，以提高效能及穩定性。</td>
</tr>
</tbody></table>

## 與 Slack 上志同道合的開發人員會談
{: #slack}

您可以看到別人談論的內容，也可以在 [{{site.data.keyword.containerlong_notm}} Slack ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://ibm-container-service.slack.com) 中提出自己的問題。
{:shortdesc}

如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶未使用 IBM ID，請[要求邀請](https://bxcs-slack-invite.mybluemix.net/)以加入此 Slack。
{: tip}
