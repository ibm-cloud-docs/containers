---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# Armazenando dados no IBM Block Storage for IBM Cloud
{: #block_storage}


## Instalando o plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage em seu cluster
{: #install_block}

Instale o plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage com um gráfico Helm para configurar classes de armazenamento predefinidas para armazenamento de bloco. É possível usar essas classes de armazenamento para criar um PVC para provisionar armazenamento de bloco para seus apps.
{: shortdesc}

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster no qual deseja instalar o plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage.


1. Siga as [instruções](cs_integrations.html#helm) para instalar o cliente Helm em sua máquina local, instalar o servidor Helm (tiller) em seu cluster e incluir o repositório de gráfico Helm do {{site.data.keyword.Bluemix_notm}} no cluster no qual você deseja usar o plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage.

   **Importante:** se você usar o Helm versão 2.9 ou superior, certifique-se de ter instalado o tiller com uma [conta do serviço](cs_integrations.html#helm).

2. Atualize o repositório Helm para recuperar a versão mais recente de todos os gráficos Helm nesse repositório.
   ```
   helm repo update
   ```
   {: pre}

3. Instale o {{site.data.keyword.Bluemix_notm}} Block Storage plug-in. Quando você instala o plug-in, classes de armazenamento de bloco predefinidas são incluídas no cluster.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   Saída de exemplo:
   ```
   NAME:   bald-olm
   LAST DEPLOYED: Wed Apr 18 10:02:55 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1beta1/DaemonSet
   NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

   ==> v1beta1/Deployment
   NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-block-storage-plugin  1        0        0           0          0s

   ==> v1/StorageClass
   NAME                      PROVISIONER        AGE
   ibmc-block-bronze         ibm.io/ibmc-block  0s
   ibmc-block-custom         ibm.io/ibmc-block  0s
   ibmc-block-gold           ibm.io/ibmc-block  0s
   ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
   ibmc-block-retain-custom  ibm.io/ibmc-block  0s
   ibmc-block-retain-gold    ibm.io/ibmc-block  0s
   ibmc-block-retain-silver  ibm.io/ibmc-block  0s
   ibmc-block-silver         ibm.io/ibmc-block  0s

   ==> v1/ServiceAccount
   NAME                           SECRETS  AGE
   ibmcloud-block-storage-plugin  1        0s

   ==> v1beta1/ClusterRole
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   ==> v1beta1/ClusterRoleBinding
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   NOTES:
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. Verifique se a instalação foi bem-sucedida.
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   Saída de exemplo:
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   A instalação é bem-sucedida quando você vê um pod `ibmcloud-block-storage-plugin` e um ou mais pods `ibmcloud-block-storage-driver`. O número de pods `ibmcloud-block-storage-driver` é igual ao número de nós do trabalhador em seu cluster. Todos os pods devem estar em um estado **Executando**.

5. Verifique se as classes de armazenamento para armazenamento de bloco foram incluídas no cluster.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   Saída de exemplo:
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. Repita essas etapas para cada cluster no qual você deseja provisionar armazenamento de bloco.

Agora é possível continuar a [criar um PVC](#add_block) para provisionar armazenamento de bloco para seu app.


### Atualizando o plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage
É possível fazer upgrade do plug-in existente do {{site.data.keyword.Bluemix_notm}} Block Storage para a versão mais recente.
{: shortdesc}

Antes de iniciar, [direcione sua CLI](cs_cli_install.html#cs_cli_configure) para o cluster.

1. Atualize o repositório Helm para recuperar a versão mais recente de todos os gráficos Helm nesse repositório.
   ```
   helm repo update
   ```
   {: pre}

2. Opcional: faça download do gráfico Helm mais recente em sua máquina local. Em seguida, descompacte o arquivo ZIP do pacote e revise o arquivo `release.md` para localizar as informações mais recentes sobre a liberação.
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. Localize o nome do gráfico do Helm de armazenamento de bloco que você instalou em seu cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Saída de exemplo:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. Faça upgrade do plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage para a versão mais recente.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. Opcional: quando você atualiza o plug-in, a classe de armazenamento `default` está desconfigurada. Se você deseja configurar a classe de armazenamento padrão para uma classe de armazenamento de sua escolha, execute o comando a seguir.
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### Removendo o plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage
Se você não deseja provisionar e usar o {{site.data.keyword.Bluemix_notm}} Block Storage em seu cluster, é possível desinstalar o gráfico Helm.
{: shortdesc}

**Nota:** a remoção do plug-in não remove os PVCs, PVs ou dados existentes. Quando você remove o plug-in, todos os pods e conjuntos de daemon relacionados são removidos do cluster. Não é possível provisionar novo armazenamento de bloco para seu cluster ou usar PVCs e PVs de armazenamento de bloco existentes depois de remover o plug-in.

Antes de iniciar:
- [Direcione sua CLI](cs_cli_install.html#cs_cli_configure)  para o cluster.
- Certifique-se de que você não tenha nenhum PVC ou PV em seu cluster que use armazenamento de bloco.

Para remover o plug-in:

1. Localize o nome do gráfico do Helm de armazenamento de bloco que você instalou em seu cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Saída de exemplo:
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Exclua o plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage.
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. Verifique se os pods de armazenamento de bloco foram removidos.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   A remoção dos pods será bem-sucedida se nenhum pod for exibido na saída da CLI.

4. Verifique se as classes de armazenamento do armazenamento de bloco foram removidas.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   A remoção das classes de armazenamento será bem-sucedida se nenhuma classe de armazenamento for exibida na saída da CLI.

<br />



## Decidindo sobre a configuração de armazenamento de bloco
{: #predefined_storageclass}

O {{site.data.keyword.containerlong}} fornece classes de armazenamento predefinidas para armazenamento de bloco que podem ser usadas para provisionar armazenamento de bloco com uma configuração específica.
{: shortdesc}

Cada classe de armazenamento especifica o tipo de armazenamento de bloco que você provisiona, incluindo o tamanho disponível, o IOPS, o sistema de arquivos e a política de retenção.  

**Importante:** escolha a sua configuração de armazenamento com cuidado para ter capacidade suficiente para armazenar os seus dados. Após você provisionar um tipo específico de armazenamento usando uma classe de armazenamento, não será possível mudar o tamanho, o tipo, o IOPS ou a política de retenção para o dispositivo de armazenamento. Se você precisar de mais armazenamento ou armazenamento com uma configuração diferente, deverá [criar uma nova instância de armazenamento e copiar os dados](cs_storage_basics.html#update_storageclass) da instância de armazenamento antiga para a sua nova.

1. Liste as classes de armazenamento disponíveis no  {{site.data.keyword.containerlong}}.
    ```
    kubectl get storageclasses | grep block
    ```
    {: pre}

    Saída de exemplo:
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-block-custom            ibm.io/ibmc-block
    ibmc-block-bronze            ibm.io/ibmc-block
    ibmc-block-gold              ibm.io/ibmc-block
    ibmc-block-silver            ibm.io/ibmc-block
    ibmc-block-retain-bronze     ibm.io/ibmc-block
    ibmc-block-retain-silver     ibm.io/ibmc-block
    ibmc-block-retain-gold       ibm.io/ibmc-block
    ibmc-block-retain-custom     ibm.io/ibmc-block
    ```
    {: screen}

2. Revise a configuração de uma classe de armazenamento.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   Para obter mais informações sobre cada classe de armazenamento, consulte a [referência de classe de armazenamento](#storageclass_reference). Se você não localizar o que está procurando, considere criar a sua própria classe de armazenamento customizada. Para iniciar, efetue check-out das [amostras de classe de armazenamento customizada](#custom_storageclass).
   {: tip}

3. Escolha o tipo de armazenamento de bloco que você deseja provisionar.
   - **Classes de armazenamento bronze, prata e ouro:** essas classes de armazenamento provisionam [Armazenamento do Endurance ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage). O armazenamento do Endurance permite que você escolha o tamanho do armazenamento em gigabytes em camadas do IOPS predefinidas.
   - **Classe de armazenamento customizada:** essa classe de armazenamento provisiona [Armazenamento de desempenho ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/performance-storage). Com o armazenamento de desempenho, você tem mais controle sobre o tamanho do armazenamento e do IOPS.

4. Escolha o tamanho e o IOPS para seu armazenamento de bloco. O tamanho e o número de IOPS definem o número total de IOPS (operações de entrada/saída por segundo) que serve como um indicador de quão rápido o seu armazenamento é. Quanto mais total de IOPS o seu armazenamento tiver, mais rápido ele processará operações de leitura e gravação.
   - **Classes de armazenamento bronze, prata e ouro:** essas classes de armazenamento vêm com um número fixo de IOPS por gigabyte e são provisionadas em discos rígidos SSD. O número total de IOPS depende do tamanho do armazenamento que você escolher. É possível selecionar qualquer número inteiro de gigabyte dentro do intervalo de tamanho permitido, como 20 Gi, 256 Gi ou 11854 Gi. Para determinar o número total de IOPS, deve-se multiplicar o IOPS com o tamanho selecionado. Por exemplo, se você selecionar um tamanho de armazenamento de bloco de 1000Gi na classe de armazenamento prata que é fornecida com 4 IOPS por GB, seu armazenamento terá um total de 4.000 IOPS.  
     <table>
         <caption>Tabela de intervalos de tamanho de classe de armazenamento e IOPS por gigabyte</caption>
         <thead>
         <th>Classe de armazenamento</th>
         <th>IOPS por gigabyte</th>
         <th>Intervalo de tamanho em gigabytes</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronze</td>
         <td>2 IOPS/GB</td>
         <td>20-12.000 Gi</td>
         </tr>
         <tr>
         <td>Prata</td>
         <td>4 IOPS/GB</td>
         <td>20-12.000 Gi</td>
         </tr>
         <tr>
         <td>Ouro</td>
         <td>10 IOPS/GB</td>
         <td>20 - 4.000 Gi</td>
         </tr>
         </tbody></table>
   - **Classe de armazenamento customizada:** quando você escolhe essa classe de armazenamento, tem mais controle sobre o tamanho e o IOPS desejados. Para o tamanho, é possível selecionar qualquer número inteiro de gigabyte dentro do intervalo de tamanho permitido. O tamanho que você escolher determinará o intervalo de IOPS que estará disponível para você. É possível escolher um IOPS que é um múltiplo de 100 que esteja no intervalo especificado. O IOPS que você escolhe é estático e não escala com o tamanho do armazenamento. Por exemplo, se você escolher 40 Gi com 100 IOPS, o seu IOPS total permanecerá 100. </br></br>A razão de IOPS para gigabyte também determina o tipo de disco rígido que é provisionado para você. Por exemplo, se você tiver 500 Gi a 100 IOPS, a sua razão de IOPS para gigabyte será 0,2. O armazenamento com uma razão menor ou igual a 0,3 é provisionado em discos rígidos SATA. Se a sua razão for maior que 0,3, o armazenamento será provisionado em discos rígidos SSD.
     <table>
         <caption>Tabela de intervalos de tamanho de classe de armazenamento customizado e IOPS</caption>
         <thead>
         <th>Intervalo de tamanho em gigabytes</th>
         <th>Intervalo de IOPS em múltiplos de 100</th>
         </thead>
         <tbody>
         <tr>
         <td>20 - 39 Gi</td>
         <td>100 - 1000 IOPS</td>
         </tr>
         <tr>
         <td>40 - 79 Gi</td>
         <td>100 - 2.000 IOPS</td>
         </tr>
         <tr>
         <td>80 - 99 Gi</td>
         <td>100 - 4.000 IOPS</td>
         </tr>
         <tr>
         <td>100 - 499 Gi</td>
         <td>100 - 6.000 IOPS</td>
         </tr>
         <tr>
         <td>500 - 999 Gi</td>
         <td>100 - 10.000 IOPS</td>
         </tr>
         <tr>
         <td>1000 - 1.999 Gi</td>
         <td>100 - 20.000 IOPS</td>
         </tr>
         <tr>
         <td>2.000 - 2.999 Gi</td>
         <td>200 - 40.000 IOPS</td>
         </tr>
         <tr>
         <td>3.000 - 3.999 Gi</td>
         <td>200 - 48.000 IOPS</td>
         </tr>
         <tr>
         <td>4.000 - 7.999 Gi</td>
         <td>300 - 48.000 IOPS</td>
         </tr>
         <tr>
         <td>8.000 - 9.999 Gi</td>
         <td>500 - 48.000 IOPS</td>
         </tr>
         <tr>
         <td>10.000 - 12.000 Gi</td>
         <td>1000 - 48.000 IOPS</td>
         </tr>
         </tbody></table>

5. Escolha se você deseja manter os seus dados após o cluster ou a solicitação de volume persistente (PVC) ser excluída.
   - Se você desejar manter seus dados, escolha uma classe de armazenamento `retain`. Quando você exclui o PVC, somente ele é excluído. O PV, o dispositivo de armazenamento físico em sua conta de infraestrutura do IBM Cloud (SoftLayer) e os seus dados ainda existem. Para recuperar o armazenamento e usá-lo em seu cluster novamente, deve-se remover o PV e seguir as etapas para [usar armazenamento de bloco existente](#existing_block).
   - Se desejar que o PV, os dados e seu dispositivo de armazenamento de bloco físico sejam excluídos quando você excluir o PVC, escolha uma classe de armazenamento sem `retain`.

6. Escolha se você deseja ser faturado por hora ou mensalmente. Verifique a [precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/block-storage/pricing) para obter mais informações. Por padrão, todos os dispositivos de armazenamento de bloco são provisionados com um tipo de faturamento por hora.

<br />



## Incluindo armazenamento de bloco em apps
{: #add_block}

Crie um persistent volume claim (PVC) para [provisionar dinamicamente](cs_storage_basics.html#dynamic_provisioning) o armazenamento de bloco para seu cluster. O fornecimento dinâmico cria automaticamente o persistent volume (PV) correspondente e pede o dispositivo de armazenamento real em sua conta de infraestrutura do IBM Cloud (SoftLayer).
{:shortdesc}

**Importante**: o armazenamento de bloco é fornecido com um modo de acesso `ReadWriteOnce`. Só é possível montá-lo em um pod em um nó do trabalhador no cluster de cada vez.

Antes de iniciar:
- Se você tiver um firewall, [permita o acesso ao egresso](cs_firewall.html#pvc) para os intervalos de IP de infraestrutura do IBM Cloud (SoftLayer) das zonas nas quais os seus clusters estiverem para que seja possível criar PVCs.
- Instale o  [ plug-in de armazenamento de bloco do {{site.data.keyword.Bluemix_notm}}  ](#install_block).
- [Decida sobre uma classe de armazenamento predefinida](#predefined_storageclass) ou crie uma [classe de armazenamento customizada](#custom_storageclass).

Para incluir o armazenamento de bloco:

1.  Crie um arquivo de configuração para definir a sua solicitação de volume persistente (PVC) e salve a configuração como um arquivo `.yaml`.

    -  **Exemplo para classes de armazenamento bronze, prata, ouro**:
       O arquivo `.yaml` a seguir cria uma solicitação que é denominada `mypvc` da classe de armazenamento `"ibmc-block-silver"`, faturada `"hourly"`, com um tamanho de gigabyte de `24Gi`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-silver"
         labels:
           billingType: "hourly"
	         region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Exemplo para usar a classe de armazenamento customizada**:
       O arquivo `.yaml` a seguir cria uma solicitação que é denominada `mypvc` da classe de armazenamento `ibmc-block-retain-custom`, faturada `"hourly"`, com um tamanho de gigabyte de `45Gi` e IOPS de `"300"`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-retain-custom"
         labels:
           billingType: "hourly"
           region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 45Gi
             iops: "300"
        ```
        {: codeblock}

        <table>
        <caption>Entendendo os componentes de arquivo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Insira o nome do PVC.</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>O nome da classe de armazenamento que você deseja usar para provisionar armazenamento de bloco. </br> Se você não especificar uma classe de armazenamento, o PV será criado com a classe de armazenamento padrão <code>ibmc-file-bronze</code><p>**Dica:** se você deseja mudar a classe de armazenamento padrão, execute <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> e substitua <code>&lt;storageclass&gt;</code> pelo nome da classe de armazenamento.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Especifique a frequência para a qual sua conta de armazenamento é calculada, como "mensal" ou "por hora". O padrão é "horária".</td>
        </tr>
	<tr>
	<td><code> metadata/labels/region </code></td>
        <td>Especifique a região na qual você deseja provisionar seu armazenamento de bloco. Se você especifica a região, deve-se também especificar uma zona. Se você não especifica uma região ou a região especificada não é localizada, o armazenamento é criado na mesma região que o seu cluster. </br><strong>Nota:</strong> essa opção é suportada somente com o plug-in do IBM Cloud Block Storage versão 1.0.1 ou superior. Para versões de plug-in mais antigas, se você tiver um cluster de múltiplas zonas, a zona na qual o seu armazenamento for provisionado será selecionada em uma base round-robin para balancear as solicitações de volume uniformemente em todas as zonas. Se você desejar especificar a zona para o seu armazenamento, crie uma [classe de armazenamento customizada](#multizone_yaml) primeiro. Em seguida, crie um PVC com a sua classe de armazenamento customizada.</td>
	</tr>
	<tr>
	<td><code> metadata/labels/zone </code></td>
	<td>Especifique a zona na qual você deseja provisionar seu armazenamento de bloco. Se você especifica a zona, deve-se também especificar uma região. Se você não especifica uma zona ou a zona especificada não é localizada em um cluster de múltiplas zonas, a zona é selecionada em uma base round-robin. </br><strong>Nota:</strong> essa opção é suportada somente com o plug-in do IBM Cloud Block Storage versão 1.0.1 ou superior. Para versões de plug-in mais antigas, se você tiver um cluster de múltiplas zonas, a zona na qual o seu armazenamento for provisionado será selecionada em uma base round-robin para balancear as solicitações de volume uniformemente em todas as zonas. Se você desejar especificar a zona para o seu armazenamento, crie uma [classe de armazenamento customizada](#multizone_yaml) primeiro. Em seguida, crie um PVC com a sua classe de armazenamento customizada.</td>
	</tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Insira o tamanho do armazenamento de bloco, em gigabytes (Gi). </br></br><strong>Nota: </strong> depois que seu armazenamento for provisionado, não será possível mudar o tamanho de seu armazenamento de bloco. Certifique-se de especificar um tamanho que corresponda à quantia de dados que você deseja armazenar. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Essa opção está disponível somente para as classes de armazenamento customizadas (`ibmc-block-custom/ibmc-block-retain-custom`). Especifique o IOPS total para o armazenamento, selecionando um múltiplo de 100 dentro do intervalo permitido. Se você escolher um IOPS diferente de um que esteja listado, o IOPS será arredondado para cima.</td>
        </tr>
        </tbody></table>

    Se você deseja usar uma classe de armazenamento customizado, crie seu PVC com o nome de classe de armazenamento correspondente, um IOPS válido e o tamanho.   
    {: tip}

2.  Crie o PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  Verifique se o PVC foi criado e ligado ao PV. Esse processo pode levar alguns minutos.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Saída de exemplo:

    ```
    Name:		mypvc
    Namespace:	default
    StorageClass:	""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m		3m		1	{ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-block", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}Para montar o PV em sua implementação, crie um arquivo de configuração `.yaml` e especifique o PVC que liga o PV.

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <caption>Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>Um rótulo para a implementação.</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>Um rótulo para o seu app.</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>Um rótulo para a implementação.</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>O nome da imagem que você deseja usar. Para listar as imagens disponíveis em sua conta do {{site.data.keyword.registryshort_notm}}, execute `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>O nome do contêiner que você deseja implementar em seu cluster.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>O caminho absoluto do diretório no qual o volume está montado dentro do contêiner. Os dados que são gravados no caminho de montagem são armazenados sob o diretório-raiz em sua instância de armazenamento de arquivo físico. Para criar diretórios em sua instância de armazenamento de arquivo físico, deve-se criar subdiretórios em seu caminho de montagem.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>O nome do volume a ser montado no pod.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>O nome do volume a ser montado no pod. Geralmente, esse nome é o mesmo que <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>O nome do PVC que liga o PV que você deseja usar. </td>
    </tr>
    </tbody></table>

5.  Crie a implementação.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  Verifique se o PV foi montado com êxito.

     ```
     kubectl describe deployment <deployment_name>
     ```
     {: pre}

     O ponto de montagem está no campo **Montagens de volume** e o volume está no campo **Volumes**.

     ```
      Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
     ...
     Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false
     ```
     {: screen}

<br />




## Usando o armazenamento de bloco existente em seu cluster
{: #existing_block}

Se você tiver um dispositivo de armazenamento físico existente que desejar usar em seu cluster, será possível criar manualmente o PV e o PVC para [provisionar estaticamente](cs_storage_basics.html#static_provisioning) o armazenamento.

Para que seja possível iniciar a montagem de seu armazenamento existente em um app, deve-se recuperar todas as informações necessárias para o seu PV.  
{: shortdesc}

### Etapa 1: recuperando as informações de seu armazenamento de bloco existente

1.  Recupere ou gere uma chave API para sua conta de infraestrutura do IBM Cloud (SoftLayer).
    1. Efetue login no portal de infraestrutura do [IBM Cloud (SoftLayer)![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://control.bluemix.net/).
    2. Selecione **Conta**, depois **Usuários** e, em seguida, **Lista de usuários**.
    3. Localize seu ID de usuário.
    4. Na coluna **CHAVE API**, clique em **Gerar** para gerar uma chave API ou em **Visualizar** para visualizar a chave API existente.
2.  Recupere o nome de usuário da API da conta de infraestrutura do IBM Cloud (SoftLayer).
    1. No menu **Lista de usuários**, selecione seu ID de usuário.
    2. Na seção **Informações de acesso da API**, localize o seu **Nome do usuário da API**.
3.  Efetue login no plug-in da CLI da infraestrutura do IBM Cloud.
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  Escolha autenticar-se usando o nome de usuário e a chave API da conta de infraestrutura do IBM Cloud (SoftLayer).
5.  Insira o nome de usuário e a chave API recuperados nas etapas anteriores.
6.  Liste os dispositivos de armazenamento de bloco disponíveis.
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    Saída de exemplo:
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  Anote o `id`, `ip_addr`, `capacity_gb`, `datacenter` e `lunId` do dispositivo de armazenamento de bloco que você deseja montar em seu cluster. **Nota:** para montar o armazenamento existente em um cluster, deve-se ter um nó do trabalhador na mesma zona que seu armazenamento. Para verificar a zona de seu nó do trabalhador, execute `ibmcloud ks workers <cluster_name_or_ID>`.

### Etapa 2: Criando um volume persistente (PV) e uma solicitação de volume persistente correspondente (PVC)

1.  Opcional: se você tiver o armazenamento provisionado com uma classe de armazenamento `retain`, quando remover o PVC, o PV e o dispositivo de armazenamento físico não serão removidos. Para reutilizar o armazenamento em seu cluster, deve-se remover o PV primeiro.
    1. Liste PVs existentes.
       ```
       kubectl get pv
       ```
       {: pre}

       Procure o PV que pertence ao seu armazenamento persistente. O PV está em um estado `released`.

    2. Remova o PV.
       ```
       kubectl delete pv <pv_name>
       ```
       {: pre}

    3. Verifique se o PV foi removido.
       ```
       kubectl get pv
       ```
       {: pre}

2.  Crie um arquivo de configuração para seu PV. Inclua o armazenamento de bloco `id`, `ip_addr`, `capacity_gb`, `datacenter` e `lunIdID` que você recuperou anteriormente.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region: <region>
         failure-domain.beta.kubernetes.io/zone: <zone>
    spec:
      capacity:
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
      ```
      {: codeblock}

    <table>
    <caption>Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Insira o nome do PV que você deseja criar.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Insira a região e a zona que você recuperou anteriormente. Deve-se ter pelo menos um nó do trabalhador na mesma região e zona que o seu armazenamento persistente para montar o armazenamento em seu cluster. Se um PV para o seu armazenamento já existir, [inclua o rótulo de zona e região](cs_storage_basics.html#multizone) em seu PV.
    </tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>Insira o tipo de sistema de arquivos que está configurado para seu armazenamento de bloco existente. Escolha entre <code>ext4</code> ou <code>xfs</code>. Se você não especificar essa opção, o PV assumirá o padrão para <code>ext4</code>. Quando o fsType errado é definido, a criação de PV é bem-sucedida, mas a montagem do PV em um pod falha. </td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Insira o tamanho da área de armazenamento do armazenamento de bloco existente recuperado na etapa anterior como <code>capacity-gb</code>. O tamanho do armazenamento deve ser gravado em gigabytes, por exemplo, 20 Gi (20 GB) ou 1000 Gi (1 TB).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>Insira o ID de LUN para o armazenamento de bloco que você recuperou anteriormente como <code>lunId</code>.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>Insira o endereço IP do armazenamento de bloco que você recuperou anteriormente como <code>ip_addr</code>. </td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>Insira o ID do armazenamento de bloco que você recuperou anteriormente como <code>id</code>.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>Insira um nome para seu volume.</td>
	    </tr>
    </tbody></table>

3.  Crie o PV em seu cluster.
    ```
    Kubectl apply mypv.yaml -f
    ```
    {: pre}

4. Verifique se o PV é criado.
    ```
    kubectl get pv
    ```
    {: pre}

5. Crie outro arquivo de configuração para criar seu PVC. Para que o PVC corresponda ao PV criado anteriormente, deve-se escolher o mesmo valor para `storage` e `accessMode`. O campo `storage-class` deve estar vazio. Se algum desses campos não corresponder ao PV, um novo PV será criado automaticamente no lugar.

     ```
     kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
     spec: accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: "<storage_size>"
     ```
     {: codeblock}

6.  Crie seu PVC.
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  Verifique se o PVC foi criado e está ligado ao PV criado anteriormente. Esse processo pode levar alguns minutos.
     ```
     kubectl describe pvc mypvc
     ```
     {: pre}

     Saída de exemplo:

     ```
     Name: mypvc
    Namespace: default
    StorageClass: ""
     Status: Bound
     Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     Labels: <none>
     Capacity: 20Gi
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

Você criou com êxito um PV e ligou-o a um PVC. Os usuários do cluster agora podem [montar o PVC](#app_volume_mount) em suas implementações e começar a ler e gravar no PV.

<br />



## Backup e restauração de dados
{: #backup_restore}

O armazenamento de bloco é provisionado no mesmo local que os nós do trabalhador em seu cluster. O armazenamento é hospedado em servidores em cluster pela IBM para fornecer disponibilidade no caso de um servidor ficar inativo. No entanto, o armazenamento de bloco não será submetido a backup automaticamente e poderá estar inacessível se o local inteiro falhar. Para proteger seus dados contra perda ou danos, será possível configurar backups periódicos que poderão ser usados para restaurar seus dados quando necessário.

Revise as opções de backup e restauração a seguir para seu armazenamento de bloco:

<dl>
  <dt>Configurar capturas instantâneas periódicas</dt>
  <dd><p>É possível [configurar capturas instantâneas periódicas para o seu armazenamento de bloco](/docs/infrastructure/BlockStorage/snapshots.html#snapshots), que é uma imagem somente leitura que captura o estado da instância em um momento. Para armazenar a captura instantânea, deve-se solicitar espaço de captura instantânea em seu armazenamento de bloco. As capturas instantâneas são armazenadas na instância de armazenamento existente dentro da mesma zona. É possível restaurar dados de uma captura instantânea se um usuário acidentalmente remove dados importantes do volume. <strong>Nota</strong>: se você tiver uma conta Dedicada, deverá <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">abrir um chamado de suporte</a>.</br></br> <strong>Para criar uma captura instantânea para seu volume: </strong><ol><li>PVs de Lista existente em seu cluster. <pre class="pre"><code>kubectl get pv</code></pre></li><li>Obtenha os detalhes para o PV para o qual você deseja criar espaço de captura instantânea e anote o ID do volume, o tamanho e os IOPS. <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> O tamanho e o IOPS são mostrados na seção <strong>Labels</strong> de sua saída da CLI. Para localizar o ID do volume, revise a anotação <code>ibm.io/network-storage-id</code> de sua saída da CLI. </li><li>Crie o tamanho da captura instantânea para o volume existente com os parâmetros que você recuperou na etapa anterior. <pre class="pre"><code>slcli block snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>Espere o tamanho da captura instantânea para criar. <pre class="pre">
<code>slcli block volume-detail &lt;volume_id&gt;</code></pre>O tamanho da captura instantânea é provisionado com êxito quando o <strong>Snapshot Capacity (GB)</strong> em sua saída da CLI muda de 0 para o tamanho que você pediu. </li><li>Crie a captura instantânea para o volume e anote o ID da captura instantânea que é criado para você. <pre class="pre"><code>slcli block snapshot-create &lt;volume_id&gt;</code></pre></li><li>Verifique se a captura instantânea foi criada com êxito. <pre class="pre"><code>slcli block volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>Para restaurar dados por meio de uma captura instantânea para um volume existente: </strong><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>Replicar capturas instantâneas para outra zona</dt>
 <dd><p>Para proteger seus dados de uma falha de zona, é possível [replicar capturas instantâneas](/docs/infrastructure/BlockStorage/replication.html#replicating-data) para uma instância de armazenamento de bloco que está configurada em outra zona. Os dados podem ser replicados do armazenamento primário para o armazenamento de backup somente. Não é possível montar uma instância de armazenamento de bloco replicada em um cluster. Quando seu armazenamento primário falha, é possível configurar manualmente o armazenamento de backup replicado para ser o primário. Em seguida, é possível montá-lo para seu cluster. Depois que o armazenamento primário é restaurado, é possível restaurar os dados do armazenamento de backup. <strong>Nota</strong>: se você tiver uma conta Dedicada, não será possível replicar capturas instantâneas para outra zona.</p></dd>
 <dt>Armazenamento duplicado</dt>
 <dd><p>É possível [duplicar sua instância de armazenamento de bloco](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume) na mesma zona que a instância de armazenamento original. Uma duplicata tem os mesmos dados que a instância de armazenamento original no momento em que é criada. Diferentemente de réplicas, use a duplicata como uma instância de armazenamento independente da original. Para duplicar, primeiramente configure capturas instantâneas para o volume. <strong>Nota</strong>: se você tiver uma conta Dedicada, deverá <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">abrir um chamado de suporte</a>.</p></dd>
  <dt>Faça backup dos dados para {{site.data.keyword.cos_full}}</dt>
  <dd><p>É possível usar a [**imagem ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) para ativar um backup e restaurar o pod em seu cluster. Esse pod contém um script para executar um backup único ou periódico para qualquer persistent volume claim (PVC) em seu cluster. Os dados são armazenados em sua instância do {{site.data.keyword.cos_full}} que você configurou em uma zona.</p><strong>Nota:</strong> o armazenamento de bloco é montado com um modo de acesso RWO. Esse acesso permite que somente um pod seja montado no armazenamento de bloco de cada vez. Para fazer backup de seus dados, deve-se desmontar o pod de app do armazenamento, montá-lo em seu pod de backup, fazer backup dos dados e remontar o armazenamento em seu pod de app. </br></br>
Para tornar os seus dados ainda mais altamente disponíveis e proteger o seu app de uma falha de zona, configure uma segunda instância do {{site.data.keyword.cos_short}} e replique dados entre as zonas. Se você precisa restaurar dados de sua instância do {{site.data.keyword.cos_short}}, use o script de restauração que é fornecido com a imagem.</dd>
<dt>Copiar dados de e para pods e contêineres</dt>
<dd><p>É possível usar o [comando `kubectl cp` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) para copiar arquivos e diretórios de pods ou contêineres específicos ou para eles em seu cluster.</p>
<p>Antes de iniciar, [direcione sua CLI do Kubernetes](cs_cli_install.html#cs_cli_configure) para o cluster que deseja usar. Se você não especificar um contêiner com <code>-c</code>, o comando usará o primeiro contêiner disponível no pod.</p>
<p>É possível usar o comando de várias maneiras:</p>
<ul>
<li>Copiar dados de sua máquina local para um pod no cluster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copiar dados de um pod em seu cluster para a máquina local: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copiar dados de sua máquina local para um contêiner específico que é executado em um pod em seu cluster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Referência de classe de armazenamento
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Classe de armazenamento de bloco: bronze</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code> ibmc-block-bronze </code></br><code> ibmc-block-retain-bronze </code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Armazenamento do Endurance![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS por gigabyte</td>
<td>2</td>
</tr>
<tr>
<td>Intervalo de tamanho em gigabytes</td>
<td>20-12.000 Gi</td>
</tr>
<tr>
<td>Disco rígido</td>
<td>SSD</td>
</tr>
<tr>
<td>Faturamento</td>
<td>O tipo de faturamento padrão depende da versão de seu plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versão 1.0.1 e superior: por hora</li><li>Versão 1.0.0 e inferior: mensal</li></ul></td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### Prata
{: #silver}

<table>
<caption>Classe de armazenamento de bloco: prata</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code>ibmc-block-silver</code></br><code> ibmc-block-retain-silver </code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Armazenamento do Endurance![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS por gigabyte</td>
<td>4</td>
</tr>
<tr>
<td>Intervalo de tamanho em gigabytes</td>
<td>20-12.000 Gi</td>
</tr>
<tr>
<td>Disco rígido</td>
<td>SSD</td>
</tr>
<tr>
<td>Faturamento</td>
<td>O tipo de faturamento padrão depende da versão de seu plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versão 1.0.1 e superior: por hora</li><li>Versão 1.0.0 e inferior: mensal</li></ul></td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Ouro
{: #gold}

<table>
<caption>Classe de armazenamento de bloco: ouro</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code> ibmc-block-gold </code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Armazenamento do Endurance![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS por gigabyte</td>
<td>10</td>
</tr>
<tr>
<td>Intervalo de tamanho em gigabytes</td>
<td>20 - 4.000 Gi</td>
</tr>
<tr>
<td>Disco rígido</td>
<td>SSD</td>
</tr>
<tr>
<td>Faturamento</td>
<td>O tipo de faturamento padrão depende da versão de seu plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versão 1.0.1 e superior: por hora</li><li>Versão 1.0.0 e inferior: mensal</li></ul></td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Customizado
{: #custom}

<table>
<caption>Classe de armazenamento de bloco: customizada</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code> ibmc-block-custom </code></br><code> ibmc-block-retain-custom </code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Desempenho ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS e tamanho</td>
<td><strong>Intervalo de tamanho em intervalo de gigabytes/IOPS em múltiplos de 100</strong><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Disco rígido</td>
<td>A razão de IOPS para gigabyte determina o tipo de disco rígido que é provisionado. Para determinar a sua razão de IOPS para gigabyte, você divide o IOPS pelo tamanho de seu armazenamento. </br></br>Exemplo: </br>Você escolheu 500 Gi de armazenamento com 100 IOPS. A sua razão é 0,2 (100 IOPS/500 Gi). </br></br><strong>Visão geral de tipos de disco rígido por razão:</strong><ul><li>Menor ou igual a 0,3: SATA</li><li>Maior que 0,3: SSD</li></ul></td>
</tr>
<tr>
<td>Faturamento</td>
<td>O tipo de faturamento padrão depende da versão de seu plug-in do {{site.data.keyword.Bluemix_notm}} Block Storage: <ul><li> Versão 1.0.1 e superior: por hora</li><li>Versão 1.0.0 e inferior: mensal</li></ul></td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Classes de armazenamento customizado de amostra
{: #custom_storageclass}

### Especificando a zona para clusters de múltiplas zonas
{: #multizone_yaml}

O arquivo `.yaml` a seguir customiza uma classe de armazenamento que é baseada na classe de armazenamento sem retenção `ibm-block-silver`: o `type` é `"Endurance"`, o `iopsPerGB` é `4`, o `sizeRange` é `"[20-12000]Gi"` e o `reclaimPolicy` é configurado para `"Delete"`. A zona é especificada como `dal12`. É possível revisar as informações anteriores sobre as classes de armazenamento `ibmc` para ajudar a escolher valores aceitáveis para esses </br>

Para usar uma classe de armazenamento diferente como sua base, consulte a [referência de classe de armazenamento](#storageclass_reference).

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### Montando o armazenamento de bloco com um sistema de arquivos `XFS`
{: #xfs}

O exemplo a seguir cria uma classe de armazenamento que é denominada `ibmc-block-custom-xfs` e que provisiona o armazenamento de bloco de desempenho com um sistema de arquivos `XFS`.

```
apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-block-custom-xfs
     labels:
       addonmanager.kubernetes.io/mode: Reconcile
   provisioner: ibm.io/ibmc-block
   parameters:
     type: "Performance"
     sizeIOPSRange: |-
       [20-39]Gi:[100-1000]
       [40-79]Gi:[100-2000]
       [80-99]Gi:[100-4000]
       [100-499]Gi:[100-6000]
       [500-999]Gi:[100-10000]
       [1000-1999]Gi:[100-20000]
       [2000-2999]Gi:[200-40000]
       [3000-3999]Gi:[200-48000]
       [4000-7999]Gi:[300-48000]
       [8000-9999]Gi:[500-48000]
       [10000-12000]Gi:[1000-48000]
  fsType: "xfs"
     reclaimPolicy: "Delete"
     classVersion: "2"
```
{: codeblock}

<br />

