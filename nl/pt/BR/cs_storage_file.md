---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Armazenando dados no IBM File Storage for IBM Cloud
{: #file_storage}


## Decidindo sobre a configuração de armazenamento de arquivo
{: #predefined_storageclass}

O {{site.data.keyword.containerlong}} fornece classes de armazenamento predefinidas para armazenamento de arquivo que podem ser usadas para provisionar o armazenamento de arquivo com uma configuração específica.
{: shortdesc}

Cada classe de armazenamento especifica o tipo de armazenamento de arquivo que você provisiona, incluindo o tamanho disponível, o IOPS, o sistema de arquivos e a política de retenção.  

**Importante:** escolha a sua configuração de armazenamento com cuidado para ter capacidade suficiente para armazenar os seus dados. Após você provisionar um tipo específico de armazenamento usando uma classe de armazenamento, não será possível mudar o tamanho, o tipo, o IOPS ou a política de retenção para o dispositivo de armazenamento. Se você precisar de mais armazenamento ou armazenamento com uma configuração diferente, deverá [criar uma nova instância de armazenamento e copiar os dados](cs_storage_basics.html#update_storageclass) da instância de armazenamento antiga para a sua nova.

1. Liste as classes de armazenamento disponíveis no {{site.data.keyword.containerlong}}.
    ```
    kubectl get storageclasses | grep file
    ```
    {: pre}

    Saída de exemplo:
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-retain-bronze      ibm.io/ibmc-file
    ibmc-file-retain-custom      ibm.io/ibmc-file
    ibmc-file-retain-gold        ibm.io/ibmc-file
    ibmc-file-retain-silver      ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2. Revise a configuração de uma classe de armazenamento.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   Para obter mais informações sobre cada classe de armazenamento, consulte a [referência de classe de armazenamento](#storageclass_reference). Se você não localizar o que está procurando, considere criar a sua própria classe de armazenamento customizada. Para iniciar, efetue check-out das [amostras de classe de armazenamento customizada](#custom_storageclass).
   {: tip}

3. Escolha o tipo de armazenamento de arquivo que você deseja provisionar.
   - **Classes de armazenamento bronze, prata e ouro:** essas classes de armazenamento provisionam [Armazenamento do Endurance ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage). O armazenamento do Endurance permite que você escolha o tamanho do armazenamento em gigabytes em camadas do IOPS predefinidas.
   - **Classe de armazenamento customizada:** essa classe de armazenamento provisiona [Armazenamento de desempenho ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/performance-storage). Com o armazenamento de desempenho, você tem mais controle sobre o tamanho do armazenamento e do IOPS.

4. Escolha o tamanho e o IOPS para seu armazenamento de arquivo. O tamanho e o número de IOPS definem o número total de IOPS (operações de entrada/saída por segundo) que serve como um indicador de quão rápido o seu armazenamento é. Quanto mais total de IOPS o seu armazenamento tiver, mais rápido ele processará operações de leitura e gravação.
   - **Classes de armazenamento bronze, prata e ouro:** essas classes de armazenamento vêm com um número fixo de IOPS por gigabyte e são provisionadas em discos rígidos SSD. O número total de IOPS depende do tamanho do armazenamento que você escolher. É possível selecionar qualquer número inteiro de gigabyte dentro do intervalo de tamanho permitido, como 20 Gi, 256 Gi ou 11854 Gi. Para determinar o número total de IOPS, deve-se multiplicar o IOPS com o tamanho selecionado. Por exemplo, se você selecionar um tamanho de armazenamento de arquivo de 1000Gi na classe de armazenamento prata que é fornecida com 4 IOPS por GB, seu armazenamento terá um total de 4.000 IOPS.
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
   - **Classe de armazenamento customizada:** quando você escolhe essa classe de armazenamento, tem mais controle sobre o tamanho e o IOPS desejados. Para o tamanho, é possível selecionar qualquer número inteiro de gigabyte dentro do intervalo de tamanho permitido. O tamanho que você escolher determinará o intervalo de IOPS que estará disponível para você. É possível escolher um IOPS que é um múltiplo de 100 que esteja no intervalo especificado. O IOPS que você escolhe é estático e não escala com o tamanho do armazenamento. Por exemplo, se você escolher 40 Gi com 100 IOPS, o seu IOPS total permanecerá 100. </br></br> A razão de IOPS para gigabyte também determina o tipo de disco rígido que é provisionado para você. Por exemplo, se você tiver 500 Gi a 100 IOPS, a sua razão de IOPS para gigabyte será 0,2. O armazenamento com uma razão menor ou igual a 0,3 é provisionado em discos rígidos SATA. Se a sua razão for maior que 0,3, o armazenamento será provisionado em discos rígidos SSD.  
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
   - Se você desejar manter seus dados, escolha uma classe de armazenamento `retain`. Quando você exclui o PVC, somente ele é excluído. O PV, o dispositivo de armazenamento físico em sua conta de infraestrutura do IBM Cloud (SoftLayer) e os seus dados ainda existem. Para recuperar o armazenamento e usá-lo em seu cluster novamente, deve-se remover o PV e seguir as etapas para [usar o armazenamento de arquivo existente](#existing_file).
   - Se desejar que o PV, os dados e seu dispositivo de armazenamento de arquivo físico sejam excluídos quando você excluir o PVC, escolha uma classe de armazenamento sem `retain`.

6. Escolha se você deseja ser faturado por hora ou mensalmente. Verifique a [precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/file-storage/pricing) para obter mais informações. Por padrão, todos os dispositivos de armazenamento de arquivo são provisionados com um tipo de faturamento por hora.
   **Nota:** se você escolher um tipo de faturamento mensal, quando remover o armazenamento persistente, ainda assim pagará o encargo mensal por ele, mesmo que o tenha usado somente por uma curta quantia de tempo.

<br />



## Incluindo armazenamento de arquivo em apps
{: #add_file}

Crie um persistent volume claim (PVC) para [provisionar dinamicamente](cs_storage_basics.html#dynamic_provisioning) o armazenamento de arquivo para seu cluster. O fornecimento dinâmico cria automaticamente o persistent volume (PV) correspondente e pede o dispositivo de armazenamento físico em sua conta de infraestrutura do IBM Cloud (SoftLayer).
{:shortdesc}

Antes de iniciar:
- Se você tiver um firewall, [permita o acesso ao egresso](cs_firewall.html#pvc) para os intervalos de IP de infraestrutura do IBM Cloud (SoftLayer) das zonas nas quais os seus clusters estiverem para que seja possível criar PVCs.
- [Decida sobre uma classe de armazenamento predefinida](#predefined_storageclass) ou crie uma [classe de armazenamento customizada](#custom_storageclass).

  **Dica:** se você tiver um cluster de múltiplas zonas, a zona na qual seu armazenamento é provisionado será selecionada em uma base round-robin para balancear as solicitações de volume uniformemente entre todas as zonas. Se você desejar especificar a zona para o seu armazenamento, crie uma [classe de armazenamento customizada](#multizone_yaml) primeiro. Em seguida, siga as etapas neste tópico para provisionar armazenamento usando sua classe de armazenamento customizada.

Para incluir armazenamento de arquivo:

1.  Crie um arquivo de configuração para definir a sua solicitação de volume persistente (PVC) e salve a configuração como um arquivo `.yaml`.

    -  **Exemplo para classes de armazenamento bronze, prata, ouro**:
       o arquivo `.yaml` a seguir cria uma solicitação que é denominada `mypvc` da classe de armazenamento `"ibmc-file-silver"`, faturada `"monthly"`, com um tamanho de gigabyte de `24Gi`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "monthly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Exemplo para usar a classe de armazenamento customizada**:
o arquivo `.yaml` a seguir cria uma solicitação que é denominada `mypvc` da classe de armazenamento `ibmc-file-retain-custom`, faturada `"hourly"`, com um tamanho de gigabyte de `45Gi` e IOPS de `"300"`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "hourly"
       spec:
         accessModes:
           - ReadWriteMany
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
        <td>O nome da classe de armazenamento que você deseja usar para provisionar armazenamento de arquivo. </br> Se você não especificar uma classe de armazenamento, o PV será criado com a classe de armazenamento padrão <code>ibmc-file-bronze</code><p>**Dica:** se você deseja mudar a classe de armazenamento padrão, execute <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> e substitua <code>&lt;storageclass&gt;</code> pelo nome da classe de armazenamento.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Especifique a frequência para a qual sua conta de armazenamento é calculada, como "mensal" ou "por hora". Se você não especificar um tipo de faturamento, o armazenamento será provisionado com um tipo de faturamento por hora. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Insira o tamanho do armazenamento de arquivo, em gigabytes (Gi). </br></br><strong>Nota: </strong> depois que seu armazenamento for provisionado, não será possível mudar o tamanho de seu armazenamento de arquivo. Certifique-se de especificar um tamanho que corresponda à quantia de dados que você deseja armazenar. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Essa opção está disponível somente para as classes de armazenamento customizadas (`ibmc-file-custom/ibmc-file-retain-custom`). Especifique o IOPS total para o armazenamento, selecionando um múltiplo de 100 dentro do intervalo permitido. Se você escolher um IOPS diferente de um que esteja listado, o IOPS será arredondado para cima.</td>
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
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m		3m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}Para montar o armazenamento em sua implementação, crie um arquivo de configuração `.yaml` e especifique o PVC que liga o PV.

    Se você tiver um app que requer que um usuário não raiz grave no armazenamento persistente ou um app que requer que o caminho de montagem seja de propriedade do usuário raiz, consulte [Incluindo acesso de usuário não raiz no armazenamento de arquivo NFS](cs_troubleshoot_storage.html#nonroot) ou [Ativando a permissão raiz para armazenamento de arquivo NFS](cs_troubleshoot_storage.html#nonroot).
    {: tip}

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
    <td>O caminho absoluto do diretório no qual o volume está montado dentro do contêiner.</td>
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




## Usando armazenamento de arquivo existente em seu cluster
{: #existing_file}

Se você tiver um dispositivo de armazenamento físico existente que desejar usar em seu cluster, será possível criar manualmente o PV e o PVC para [provisionar estaticamente](cs_storage_basics.html#static_provisioning) o armazenamento.

Antes de iniciar, certifique-se de que tenha pelo menos um nó do trabalhador que exista na mesma zona que sua instância de armazenamento de arquivo existente.

### Etapa 1: Preparando seu armazenamento existente.

Para que seja possível iniciar a montagem de seu armazenamento existente em um app, deve-se recuperar todas as informações necessárias para seu PV e preparar o armazenamento para ser acessível em seu cluster.  

**Para armazenamento que foi provisionado com uma classe de armazenamento `retain`:** </br>
Se você provisionou o armazenamento com uma classe de armazenamento `retain` e remover o PVC, o PV e o dispositivo de armazenamento físico não serão removidos automaticamente. Para reutilizar o armazenamento em seu cluster, deve-se remover o PV restante primeiro.

Para usar o armazenamento existente em um cluster diferente daquele em que você o provisionou, siga as etapas para [armazenamento que foi criado fora do cluster](#external_storage) para incluir o armazenamento na sub-rede de seu nó do trabalhador.
{: tip}

1. Liste PVs existentes.
   ```
   kubectl get pv
   ```
   {: pre}

   Procure o PV que pertence ao seu armazenamento persistente. O PV está em um estado `released`.

2. Obter os detalhes do PV.
   ```
   kubectl describe pv <pv_name>
   ```
   {: pre}

3. Observe o `CapacityGb`, `storageClass`, `failure-domain.beta.kubernetes.io/region`, `failure-domain.beta.kubernetes.io/zone`, `server` e `path`.

4. Remova o PV.
   ```
   kubectl delete pv <pv_name>
   ```
   {: pre}

5. Verifique se o PV foi removido.
   ```
   kubectl get pv
   ```
   {: pre}

</br>

**Para armazenamento persistente que foi provisionado fora do cluster:** </br>
Se desejar usar o armazenamento existente que você provisionou anteriormente, mas nunca usou em seu cluster antes, deve-se tornar o armazenamento disponível na mesma sub-rede que os seus nós do trabalhador.

1.  {: #external_storage}No [portal de infraestrutura do IBM Cloud (SoftLayer) ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://control.bluemix.net/), clique em **Armazenamento**.
2.  Clique em **File Storage** e, no menu **Ações**, selecione **Autorizar host**.
3.  Selecione **Subnets**.
4.  Na lista suspensa, selecione a sub-rede VLAN privada à qual o seu nó do trabalhador está conectado. Para localizar a sub-rede de seu nó do trabalhador, execute `ibmcloud ks workers <cluster_name>` e compare o `Private IP` de seu nó do trabalhador com a sub-rede que você localizou na lista suspensa.
5.  Clique em **Enviar**.
6.  Clique no nome do armazenamento de arquivo.
7.  Observe o `Mount Point`, o `size` e o campo `Location`. O campo `Mount Point` é exibido como `<server>:/<path>`.

### Etapa 2: Criando um volume persistente (PV) e uma solicitação de volume persistente correspondente (PVC)

1.  Crie um arquivo de configuração de armazenamento para seu PV. Inclua os valores que você recuperou anteriormente.

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
       storage: "<size>"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "<nfs_server>"
       path: "<file_storage_path>"
    ```
    {: codeblock}

    <table>
    <caption>Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Insira o nome do objeto PV a ser criado.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Insira a região e a zona que você recuperou anteriormente. Deve-se ter pelo menos um nó do trabalhador na mesma região e zona que o seu armazenamento persistente para montar o armazenamento em seu cluster. Se um PV para o seu armazenamento já existir, [inclua o rótulo de zona e região](cs_storage_basics.html#multizone) em seu PV.
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Insira o tamanho de armazenamento do compartilhamento de arquivo NFS existente que você recuperou anteriormente. O tamanho de armazenamento deve ser gravado em gigabytes, por exemplo, 20Gi (20 GB) ou 1000Gi (1 TB), e o tamanho deve corresponder ao tamanho do compartilhamento de arquivo existente.</td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Insira o ID do servidor de compartilhamento de arquivo NFS que você recuperou anteriormente.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Insira o caminho para o compartilhamento de arquivo NFS que você recuperou anteriormente.</td>
    </tr>
    </tbody></table>

3.  Crie o PV em seu cluster.

    ```
    Deploy/kube-config/mypv.yaml kubectl apply -f
    ```
    {: pre}

4.  Verifique se o PV é criado.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Crie outro arquivo de configuração para criar seu PVC. Para que o PVC corresponda ao PV criado anteriormente, deve-se escolher o mesmo valor para `storage` e `accessMode`. O campo `storage-class` deve estar vazio. Se algum desses campos não corresponder ao PV, um novo PV e uma nova instância de armazenamento físico serão [provisionados dinamicamente](cs_storage_basics.html#dynamic_provisioning).

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec: accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "<size>"
    ```
    {: codeblock}

6.  Crie seu PVC.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Verifique se o PVC foi criado e ligado ao PV. Esse processo pode levar alguns minutos.

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
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Você criou com êxito um PV e ligou-o a um PVC. Os usuários do cluster agora podem [montar o PVC](#app_volume_mount) para suas implementações e começar a ler e gravar no objeto PV.

<br />



## Mudando a versão do NFS padrão
{: #nfs_version}

A versão do armazenamento de arquivo determina o protocolo que é usado para se comunicar com o servidor de armazenamento de arquivo do {{site.data.keyword.Bluemix_notm}}. Por padrão, todas as instâncias de armazenamento de arquivo são configuradas com o NFS versão 4. É possível mudar o PV existente para uma versão mais antiga do NFS se seu app requer uma versão específica para funcionar adequadamente.
{: shortdesc}

Para mudar a versão do NFS padrão, é possível criar uma nova classe de armazenamento para provisionar o armazenamento de arquivo dinamicamente em seu cluster ou escolher mudar um PV existente que é montado em seu pod.

**Importante:** para aplicar as atualizações de segurança mais recentes e para obter um melhor desempenho, use a versão padrão do NFS e não mude para uma versão mais antiga do NFS.

**Para criar uma classe de armazenamento customizado com a versão desejada do NFS:**
1. Crie uma [classe de armazenamento customizada](#nfs_version_class) com a versão do NFS que você deseja provisionar.
2. Crie a classe de armazenamento em seu cluster.
   ```
   kubectl apply -f <filepath/nfsversion_storageclass.yaml>
   ```
   {: pre}

3. Verifique se a classe de armazenamento customizado foi criada.
   ```
   kubectl get storageclasses
   ```
   {: pre}

4. Provisione o [armazenamento de arquivo](#add_file) com sua classe de armazenamento customizada.

**Para mudar seu PV existente para usar uma versão diferente do NFS:**

1. Obtenha o PV do armazenamento de arquivo no qual você deseja mudar a versão do NFS e anote o nome do PV.
   ```
   kubectl get pv
   ```
   {: pre}

2. Inclua uma anotação em seu PV. Substitua `<version_number>` pela versão do NFS que você deseja usar. Por exemplo, para mudar para o NFS versão 3.0, insira **3**.  
   ```
   kubectl patch pv <pv_name> -p '{"metadata": {"annotations":{"volume.beta.kubernetes.io/mount-options":"vers=<version_number>"}}}'
   ```
   {: pre}

3. Exclua o pod que usa o armazenamento de arquivos e recrie o pod.
   1. Salve o yaml do pod em sua máquina local.
      ```
      kubect get pod <pod_name> -o yaml > <filepath/pod.yaml>
      ```
      {: pre}

   2. Exclua o pod.
      ```
      kubectl deleted pod <pod_name>
      ```
      {: pre}

   3. Recrie o pod.
      ```
      kubectl apply -f <filepath/pod.yaml>
      ```
      {: pre}

4. Aguarde o pod para implementar.
   ```
   kubectl get pods
   ```
   {: pre}

   O pod é totalmente implementado quando o status muda para `Running`.

5. Efetue login em seu pod.
   ```
   Kubectl exec -it < pod_name> sh
   ```
   {: pre}

6. Verifique se o armazenamento de arquivo foi montado com a versão do NFS que você especificou anteriormente.
   ```
   mount | grep "nfs" | awk -F" |," '{ print $5, $8 }'
   ```
   {: pre}

   Saída de exemplo:
   ```
   Nfs vers=3.0
   ```
   {: screen}

<br />


## Backup e restauração de dados
{: #backup_restore}

O armazenamento de arquivo é provisionado no mesmo local que os nós do trabalhador em seu cluster. O armazenamento é hospedado em servidores em cluster pela IBM para fornecer disponibilidade no caso de um servidor ficar inativo. No entanto, o armazenamento de arquivo não será submetido a backup automaticamente e poderá ser inacessível se o local inteiro falhar. Para proteger seus dados contra perda ou danos, será possível configurar backups periódicos que poderão ser usados para restaurar seus dados quando necessário.
{: shortdesc}

Revise as opções de backup e restauração a seguir para o seu armazenamento de arquivo:

<dl>
  <dt>Configurar capturas instantâneas periódicas</dt>
  <dd><p>É possível [configurar capturas instantâneas periódicas para o seu armazenamento de arquivo](/docs/infrastructure/FileStorage/snapshots.html), que é uma imagem somente leitura que captura o estado da instância em um momento. Para armazenar a captura instantânea, deve-se solicitar espaço de captura instantânea em seu armazenamento de arquivo. As capturas instantâneas são armazenadas na instância de armazenamento existente dentro da mesma zona. É possível restaurar dados de uma captura instantânea se um usuário acidentalmente remove dados importantes do volume. </br></br> <strong>Para criar uma captura instantânea para seu volume: </strong><ol><li>PVs de Lista existente em seu cluster. <pre class="pre"><code>kubectl get pv</code></pre></li><li>Obtenha os detalhes para o PV para o qual você deseja criar espaço de captura instantânea e anote o ID do volume, o tamanho e os IOPS. <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> O ID do volume, o tamanho e o IOPS podem ser localizados na seção <strong>Labels</strong> de sua saída da CLI. </li><li>Crie o tamanho da captura instantânea para o volume existente com os parâmetros que você recuperou na etapa anterior. <pre class="pre"><code>slcli file snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>Espere o tamanho da captura instantânea para criar. <pre class="pre"><code>slcli arquivo volume-detail &lt;volume_id&gt;</code></pre>O tamanho da captura instantânea é provisionado com êxito quando o <strong>Snapshot Capacity (GB)</strong> em sua saída da CLI muda de 0 para o tamanho que você pediu. </li><li>Crie a captura instantânea para o volume e anote o ID da captura instantânea que é criado para você. <pre class="pre"><code>slcli file snapshot-create &lt;volume_id&gt;</code></pre></li><li>Verifique se a captura instantânea foi criada com êxito. <pre class="pre"><code>slcli arquivo volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>Para restaurar dados por meio de uma captura instantânea para um volume existente: </strong><pre class="pre"><code>slcli file snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>Replicar capturas instantâneas para outra zona</dt>
 <dd><p>Para proteger seus dados de uma falha de zona, é possível [replicar capturas instantâneas](/docs/infrastructure/FileStorage/replication.html#replicating-data) para uma instância de armazenamento de arquivo que está configurada em outra zona. Os dados podem ser replicados do armazenamento primário para o armazenamento de backup somente. Não é possível montar uma instância de armazenamento de arquivo replicada em um cluster. Quando seu armazenamento primário falha, é possível configurar manualmente o armazenamento de backup replicado para ser o primário. Em seguida, é possível montá-lo para seu cluster. Depois que o armazenamento primário é restaurado, é possível restaurar os dados do armazenamento de backup. </p></dd>
 <dt>Armazenamento duplicado</dt>
 <dd><p>É possível [duplicar sua instância de armazenamento de arquivo](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage) na mesma zona que a instância de armazenamento original. Uma duplicata tem os mesmos dados que a instância de armazenamento original no momento em que é criada. Diferentemente de réplicas, use a duplicata como uma instância de armazenamento independente da original. Para duplicar, primeiro [configure capturas instantâneas para o volume](/docs/infrastructure/FileStorage/snapshots.html).</p></dd>
  <dt>Faça backup dos dados para {{site.data.keyword.cos_full}}</dt>
  <dd><p>É possível usar a [**imagem ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) para ativar um backup e restaurar o pod em seu cluster. Esse pod contém um script para executar um backup único ou periódico para qualquer persistent volume claim (PVC) em seu cluster. Os dados são armazenados em sua instância do {{site.data.keyword.cos_full}} que você configurou em uma zona.</p>
  <p>Para tornar os seus dados ainda mais altamente disponíveis e proteger o seu app de uma falha de zona, configure uma segunda instância do {{site.data.keyword.cos_full}} e replique dados entre as zonas. Se você precisa restaurar dados de sua instância do {{site.data.keyword.cos_full}}, use o script de restauração que é fornecido com a imagem.</p></dd>
<dt>Copiar dados de e para pods e contêineres</dt>
<dd><p>É possível usar o [comando `kubectl cp` ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) para copiar arquivos e diretórios de pods ou contêineres específicos ou para eles em seu cluster.</p>
<p>Antes de iniciar, [direcione sua CLI do Kubernetes](cs_cli_install.html#cs_cli_configure) para o cluster que deseja usar. Se você não especificar um contêiner com <code>-c</code>, o comando usará o primeiro contêiner disponível no pod.</p>
<p>É possível usar o comando de várias maneiras:</p>
<ul>
<li>Copiar dados de sua máquina local para um pod no cluster: <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copiar dados de um pod em seu cluster para a máquina local: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copiar dados de um pod em seu cluster para um contêiner específico em outro pod: <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> <var>&lt;namespace&gt;/&lt;other_pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Referência de classe de armazenamento
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Classe de armazenamento de arquivo: bronze</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code> ibmc-file-bronze </code></br><code> ibmc-file-retain-bronze </code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Armazenamento do Endurance![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>NFS</td>
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
<td>Horário</td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>


### Prata
{: #silver}

<table>
<caption>Classe de armazenamento de arquivo: silver</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code> ibmc-file-silver </code></br><code> ibmc-file-retain-silver </code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Armazenamento do Endurance![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>NFS</td>
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
<td>Horário</li></ul></td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Ouro
{: #gold}

<table>
<caption>Classe de armazenamento de arquivo: gold</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code> ibmc-file-gold </code></br><code> ibmc-file-retain-gold </code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Armazenamento do Endurance![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>NFS</td>
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
<td>Horário</li></ul></td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Customizado
{: #custom}

<table>
<caption>Classe de armazenamento de arquivo: customizado</caption>
<thead>
<th>Características</th>
<th>Configuração</th>
</thead>
<tbody>
<tr>
<td>Nome</td>
<td><code> ibmc-file-custom </code></br><code> ibmc-file-retain-custom </code></td>
</tr>
<tr>
<td>Tipo</td>
<td>[Desempenho ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>Sistema de arquivos</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS e tamanho</td>
<td><p><strong>Intervalo de tamanho em intervalo de gigabytes/IOPS em múltiplos de 100</strong></p><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Disco rígido</td>
<td>A razão de IOPS para gigabyte determina o tipo de disco rígido que é provisionado. Para determinar a sua razão de IOPS para gigabyte, você divide o IOPS pelo tamanho de seu armazenamento. </br></br>Exemplo: </br>Você escolheu 500 Gi de armazenamento com 100 IOPS. A sua razão é 0,2 (100 IOPS/500 Gi). </br></br><strong>Visão geral de tipos de disco rígido por razão:</strong><ul><li>Menor ou igual a 0,3: SATA</li><li>Maior que 0,3: SSD</li></ul></td>
</tr>
<tr>
<td>Faturamento</td>
<td>Horário</li></ul></td>
</tr>
<tr>
<td>Precificação</td>
<td>[Informações de precificação ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Classes de armazenamento customizado de amostra
{: #custom_storageclass}

### Especificando a zona para clusters de múltiplas zonas
{: #multizone_yaml}

O arquivo `.yaml` a seguir customiza uma classe de armazenamento que é baseada na classe de armazenamento sem retenção `ibm-file-silver`: o `type` é `"Endurance"`, o `iopsPerGB` é `4`, o `sizeRange` é `"[20-12000]Gi"` e o `reclaimPolicy` é configurado para `"Delete"`. A zona é especificada como `dal12`. É possível revisar as informações anteriores sobre as classes de armazenamento `ibmc` para ajudar a escolher valores aceitáveis para esses </br>

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-file-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-file
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

+### Changing the default NFS version
{: #nfs_version_class}

A classe de armazenamento customizada a seguir é baseada na classe de armazenamento [`ibmc-file-bronze`](#bronze) e permite definir a versão do NFS que você deseja provisionar. Por exemplo, para provisionar o NFS versão 3.0, substitua `<nfs_version>` com **3.0**.
```
apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-file-mount
     #annotations:
     #  storageclass.beta.kubernetes.io/is-default-class: "true"
     labels:
       kubernetes.io/cluster-service: "true"
   provisioner: ibm.io/ibmc-file
   parameters:
     type: "Endurance"
     iopsPerGB: "2"
     sizeRange: "[1-12000]Gi"
     reclaimPolicy: "Delete"
     classVersion: "2"
     mountOptions: nfsvers=<nfs_version>
```
{: codeblock}
