---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Salvando dados com armazenamento de volume persistente
{: #planning}

Um contêiner é, por design, de curta duração. No entanto, conforme mostrado no diagrama a seguir, é possível escolher entre várias opções para persistir dados para o caso de um failover de contêiner e para compartilhar dados entre contêineres.
{:shortdesc}

**Observação**: se você tiver um firewall, [permita acesso de saída](cs_firewall.html#pvc) para os intervalos de IP da infraestrutura do IBM Cloud (SoftLayer) dos locais (centros de dados) em que seus clusters estão, para que seja possível criar solicitações de volume persistentes.

![Opções de armazenamento persistente para implementações em clusters do Kubernetes](images/cs_planning_apps_storage.png)

|Opção|Descrição|
|------|-----------|
|Opção 1: usar `/emptyDir` para persistir dados usando o espaço em disco disponível
no nó do trabalhador<p>Esse recurso está disponível para clusters lite e padrão.</p>|Com essa opção, é possível criar um volume vazio no espaço em disco do nó do trabalhador que
está designado a um pod. O contêiner nesse pod pode ler e gravar nesse volume. Como o
volume está designado a um pod específico, os dados não podem ser compartilhados com outros pods em um conjunto de réplicas.<p>Um volume `/emptyDir` e seus dados são removidos quando o pod designado é
excluído permanentemente do nó do trabalhador.</p><p>**Nota:** se o contêiner dentro do pod travar, os dados no volume ainda ficarão disponíveis no nó do trabalhador.</p><p>Para obter mais informações, veja [Volumes do Kubernetes ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/storage/volumes/).</p>|
|Opção 2: criar uma solicitação de volume persistente para provisionar armazenamento persistente baseado no NFS para sua implementação<p>Este recurso está disponível somente para clusters padrão.</p>|<p>Com essa opção, é possível ter armazenamento persistente de dados do app e do contêiner por meio de volumes persistentes. Os volumes são hospedados no [Resistência e Desempenho do armazenamento de arquivo baseado em NFS![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://www.ibm.com/cloud/file-storage/details). O armazenamento de arquivo é criptografado em repouso e é possível criar réplicas dos dados armazenados.</p> <p>Você cria uma [solicitação de volume persistente](cs_storage.html) para iniciar uma solicitação para o armazenamento de arquivos baseado em NFS. O {{site.data.keyword.containershort_notm}} fornece classes de armazenamento predefinidas que definem o intervalo de tamanhos do armazenamento, o IOPS, a política de exclusão e as permissões de leitura e gravação para o volume. É possível
escolher entre essas classes de armazenamento ao criar sua solicitação de volume persistente. Depois de enviar uma solicitação de volume persistente, o {{site.data.keyword.containershort_notm}} provisiona dinamicamente um volume persistente que está hospedado no armazenamento de arquivo baseado em NFS. [É possível montar a solicitação de volume persistente](cs_storage.html#create) como um volume para a sua implementação para permitir que os contêineres leiam e gravem no volume. Os volumes persistentes podem ser compartilhados entre o mesmo conjunto de réplicas ou com outras implementações no mesmo cluster.</p><p>Quando um contêiner trava ou um pod é removido de um nó do trabalhador, os dados não são removidos e ainda podem ser acessados por outras implementações que montam o volume. As solicitações de volume persistente são hospedadas no armazenamento persistente, mas não possuem backups. Se você requerer um backup dos dados, crie um backup manual.</p><p>**Nota:** o armazenamento de compartilhamento de arquivo NFS é cobrado mensalmente. Se você provisionar o armazenamento persistente para seu cluster e removê-lo imediatamente, ainda pagará o encargo mensal para o armazenamento persistente, mesmo que você o tenha usado somente por um curto tempo.</p>|
|Opção 3: ligar um serviço de banco de dados {{site.data.keyword.Bluemix_notm}} ao seu pod<p>Esse recurso está disponível para clusters lite e padrão.</p>|Com essa opção, é possível persistir e acessar dados usando um serviço de nuvem de banco de dados {{site.data.keyword.Bluemix_notm}}. Ao ligar
o serviço do {{site.data.keyword.Bluemix_notm}} a um namespace em
seu cluster, um segredo do Kubernetes é criado. O segredo do Kubernetes retém a informação confidencial
sobre o serviço, como a URL para o serviço, seu nome do usuário e a senha. É possível montar o
segredo como um volume de segredo em seu pod e acessar o serviço usando as credenciais no segredo. Montando o volume de segredo em outros pods, também é possível compartilhar dados entre os pods.<p>Quando um
contêiner trava ou um pod é removido de um nó do trabalhador, os dados não são removidos e ainda podem ser
acessados por outros pods que montam o volume de segredo.</p><p>A maioria dos serviços de banco de dados do {{site.data.keyword.Bluemix_notm}} fornecem espaço em disco para
uma pequena quantia de dados sem custo, para que você possa testar seus recursos.</p><p>Para obter mais informações sobre como ligar um serviço do {{site.data.keyword.Bluemix_notm}} a um pod, veja [Incluindo os serviços do {{site.data.keyword.Bluemix_notm}} para apps no {{site.data.keyword.containershort_notm}}](cs_integrations.html#adding_app).</p>|
{: caption="Tabela. Opções de armazenamento de dados persistentes para implementações em clusters do Kubernetes" caption-side="top"}

<br />



## Usando compartilhamentos de arquivo NFS existentes em clusters
{: #existing}

Se você já tiver compartilhamentos de arquivos NFS existentes em sua conta de infraestrutura do IBM Cloud (SoftLayer) que deseja usar com o Kubernetes, será possível fazer isso criando volumes persistentes em seu compartilhamento de arquivo NFS existente. Um volume persistente é uma parte de hardware real que serve como um recurso de cluster do Kubernetes e pode ser consumido pelo usuário do cluster.
{:shortdesc}

O Kubernetes diferencia entre volumes persistentes que representam o hardware real e as solicitações de volume persistente que são solicitações para armazenamento geralmente iniciado pelo usuário do cluster. O diagrama a seguir ilustra o relacionamento entre volumes persistentes e solicitações de volumes persistentes.

![Criar volumes persistentes e solicitações de volumes persistentes](images/cs_cluster_pv_pvc.png)

 Conforme descrito no diagrama, para permitir que os compartilhamentos de arquivos NFS existentes sejam usados com o Kubernetes, deve-se criar volumes persistentes com um determinado tamanho e modo de acesso e criar uma solicitação de volume persistente que corresponda à especificação de volume persistente. Se o volume persistente e a solicitação de volume persistente correspondem, eles estão ligados entre si. Somente as solicitações de volume persistentes ligadas podem ser usadas pelo usuário do cluster para montar o volume em uma implementação. Esse processo é referido como fornecimento estático de armazenamento persistente.

Antes de iniciar, certifique-se de que você tenha um compartilhamento de arquivo NFS existente que seja possível usar para criar seu volume persistente.

**Nota:** o fornecimento estático de armazenamento persistente se aplica somente a compartilhamentos de arquivo NFS existentes. Se você não tem compartilhamentos de arquivo NFS existentes, os usuários do cluster podem usar o processo de [fornecimento dinâmico](cs_storage.html#create) para incluir volumes persistentes.

Para criar um volume persistente e uma solicitação de volume persistente correspondente, siga estas etapas.

1.  Em sua conta de infraestrutura do IBM Cloud (SoftLayer), consulte o ID e o caminho do compartilhamento de arquivo NFS no qual você deseja criar seu objeto de volume persistente. Além disso, autorize o armazenamento de arquivos para as sub-redes no cluster. Essa autorização dá a seu cluster acesso ao armazenamento.
    1.  Efetue login em sua conta de infraestrutura do IBM Cloud (SoftLayer).
    2.  Clique em **Armazenamento**.
    3.  Clique em **Armazenamento de arquivo** e, no menu **Ações**, selecione **Autorizar host**.
    4.  Clique em **Sub-redes**. Depois de autorizar, cada nó do trabalhador na sub-rede terá acesso ao armazenamento de arquivo.
    5.  Selecione a sub-rede da VLAN pública do seu cluster no menu e clique em **Enviar**. Se você precisar encontrar a sub-rede, execute `bx cs cluster-get <cluster_name> --showResources`.
    6.  Clique no nome do armazenamento de arquivo.
    7.  Anote o campo **Ponto de montagem**. O campo é exibido como `<server>:/<path>`.
2.  Crie um arquivo de configuração de armazenamento para seu volume persistente. Inclua o servidor e o caminho do campo **Ponto de montagem** do armazenamento de arquivo.

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
    <caption>Tabela. Entendendo os componentes de arquivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Insira o nome do objeto de volume persistente que você deseja criar.</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>Insira o tamanho de armazenamento do compartilhamento de arquivo NFS existente. O tamanho de armazenamento deve ser gravado em gigabytes, por exemplo, 20Gi (20 GB) ou 1000Gi (1 TB), e o tamanho deve corresponder ao tamanho do compartilhamento de arquivo existente.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Os modos de acesso definem a maneira como a solicitação de volume persistente pode ser montada em um nó do trabalhador.<ul><li>ReadWriteOnce (RWO): o volume persistente pode ser montado em implementações em um único nó do trabalhador. Contêineres em implementações que são montadas nesse volume persistente podem ser lidos e gravados no volume.</li><li>ReadOnlyMany (ROX): o volume persistente pode ser montado para implementações que estão hospedadas em múltiplos nós do trabalhador. Implementações que são montadas nesse volume persistente podem ler somente no volume.</li><li>ReadWriteMany (RWX): esse volume persistente pode ser montado para implementações que estão hospedadas em múltiplos nós do trabalhador. Implementações que são montadas nesse volume persistente podem ler e gravar no volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Insira o ID do servidor de compartilhamento de arquivo NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Insira o caminho para o compartilhamento de arquivo NFS no qual você deseja criar o objeto de volume persistente.</td>
    </tr>
    </tbody></table>

3.  Crie o objeto de volume persistente em seu cluster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Exemplo

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  Verifique se o volume persistente é criado.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Crie outro arquivo de configuração para criar sua solicitação de volume persistente. Para que a solicitação de volume persistente corresponda ao objeto de volume persistente que você criou anteriormente, deve-se escolher o mesmo valor para `storage` e `accessMode`. O campo `storage-class` deve estar vazio. Se algum desses campos não corresponder ao volume persistente, um novo volume persistente será criado automaticamente no lugar.

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

6.  Crie sua solicitação de volume persistente.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Verifique se sua solicitação de volume persistente foi criada e ligada ao objeto de volume persistente. Esse processo pode levar alguns minutos.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Sua saída é semelhante à mostrada a seguir.

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


Você criou com êxito um objeto de volume persistente e o ligou a uma solicitação de volume persistente. Os usuários do cluster agora podem [montar a solicitação de volume persistente](#app_volume_mount) para as suas implementações e começar a ler e gravar no objeto de volume persistente.

<br />


## Criando armazenamento persistente para apps
{: #create}

Crie uma solicitação de volume persistente (pvc) para provisionar o armazenamento de arquivo NFS para seu cluster. Em seguida, monte essa solicitação em uma implementação para assegurar que os dados estejam disponíveis mesmo que os pods travem ou sejam encerrados.
{:shortdesc}

O armazenamento de arquivo NFS que suporta o volume persistente é armazenado em cluster pela IBM para fornecer alta disponibilidade para seus dados.

1.  Revise as classes de armazenamento disponíveis. O {{site.data.keyword.containerlong}} fornece oito classes predefinidas de armazenamento para que o administrador de cluster não precise criar quaisquer classes de armazenamento. A classe de armazenamento `ibmc-file-bronze` é a mesmo que a classe de armazenamento `padrão`.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
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

2.  Decida se você deseja salvar seus dados e o compartilhamento de arquivo NFS após você excluir o pvc. Se você desejar manter seus dados, escolha uma classe de armazenamento `retain`. Se desejar que os dados e seu compartilhamento de arquivo sejam excluídos na exclusão do pvc, escolha uma classe de armazenamento sem `retain`.

3.  Revise o IOPS de uma classe de armazenamento e os tamanhos de armazenamento disponíveis.

    - As classes de armazenamento bronze, prata e dourada usam o [Armazenamento de resistência ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage) e têm um único IOPS definido por GB para cada classe. O IOPS total depende do tamanho do armazenamento. Por exemplo, 1000Gi pvc em 4 IOPS por GB possui um total de 4.000 IOPS.

      ```
      kubectl describe storageclasses ibmc-file-silver
      ```
      {: pre}

      O campo **Parâmetros** fornece o IOPS por GB associado à classe de armazenamento e os tamanhos disponíveis em gigabytes.

      ```
      Parâmetros:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
      ```
      {: screen}

    - As classes de armazenamento customizadas usam o [Desempenho de armazenamento ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://knowledgelayer.softlayer.com/topic/performance-storage) e possuem diferentes opções para o total do IOPS e o tamanho.

      ```
      kubectl describe storageclasses ibmc-file-retain-custom
      ```
      {: pre}

      O campo **parâmetros** fornece o IOPS associado à classe de armazenamento e os tamanhos disponíveis em gigabytes. Por exemplo, um 40Gi pvc pode selecionar o IOPS que é um múltiplo de 100 que está no intervalo de 100 a 2.000 IOPS.

      ```
      Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
      ```
      {: screen}

4.  Crie um arquivo de configuração para definir sua solicitação de volume persistente e salve a configuração como um `.yaml`.

    Exemplo para classes bronze, prata, ouro:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    Exemplo para classes customizadas:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Insira o nome da solicitação de volume persistente.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>Especifique a classe de armazenamento para o volume persistente:
      <ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS por GB.</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS por GB.</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS por GB.</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom: vários valores de IOPS disponíveis.

    </li> Se você não especificar uma classe de armazenamento, o volume persistente será criado com a classe de armazenamento bronze.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Se você escolher um tamanho diferente do listado, ele será arredondado. Se você selecionar um tamanho maior que o maior tamanho, então o tamanho será arredondado para baixo.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>Esta opção é para ibmc-file-custom / ibmc-file-retain-custom apenas. Especifique o IOPS total para o armazenamento. Execute `kubectl describe storageclasses ibmc-file-custom` para ver todas as opções. Se você escolher um IOPS diferente de um que esteja listado, o IOPS será arredondado para cima.</td>
    </tr>
    </tbody></table>

5.  Crie a solicitação de volume persistente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  Verifique se a sua solicitação de volume persistente foi criada e ligada ao volume persistente. Esse processo pode levar alguns minutos.

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    Sua saída é semelhante à mostrada a seguir.

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #app_volume_mount}Para montar a solicitação de volume persistente para sua implementação, crie um arquivo de configuração. Salve a configuração como um arquivo `.yaml`.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
     name: <deployment_name>
    replicas: 1
    template:
     metadata:
       labels:
         app: <app_name>
    spec:
     containers:
     - image: <image_name>
       name: <container_name>
       volumeMounts:
       - mountPath: /<file_path>
         name: <volume_name>
     volumes:
     - name: <volume_name>
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ícone de ideia"/> entendendo os componentes de arquivo do YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>O nome da implementação.</td>
    </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>Um rótulo para a implementação.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>O caminho absoluto do diretório no qual o volume está montado dentro da implementação.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>O nome do volume a montar para sua implementação.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>O nome do volume a montar para sua implementação. Geralmente, esse nome é o mesmo que <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>O nome da solicitação de volume persistente que você deseja usar como seu volume. Ao montar o volume para a implementação, o Kubernetes identificará o volume persistente que está ligado à solicitação de volume persistente e permitirá que o usuário leia e grave no volume persistente.</td>
    </tr>
    </tbody></table>

8.  Crie a implementação e monte a solicitação de volume persistente.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  Verifique se o volume foi montado com sucesso.

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




## Incluindo acesso de usuário não raiz no armazenamento persistente
{: #nonroot}

Os usuários não raiz não têm permissão de gravação no caminho de montagem do volume para armazenamento suportado por NFS. Para conceder permissão de gravação, deve-se editar o Dockerfile da imagem para criar um diretório no caminho de montagem com a permissão correta.
{:shortdesc}

Antes de iniciar, [destine sua CLI](cs_cli_install.html#cs_cli_configure) para seu cluster.

Se você estiver projetando um app com um usuário não raiz que requeira permissão de gravação para o volume, deverá incluir os processos a seguir no Dockerfile e no script de ponto de entrada:

-   Crie um usuário não raiz.
-   Inclua o usuário temporariamente no grupo raiz.
-   Crie um diretório no caminho de montagem do volume com as permissões de usuário corretas.

Para o {{site.data.keyword.containershort_notm}}, o proprietário padrão do caminho de montagem do volume é o proprietário `nobody`. Com o armazenamento NFS, se o proprietário não existir localmente no pod, o usuário `nobody` será criado. Os volumes são configurados para reconhecer o usuário raiz no contêiner que, para alguns apps, é o único usuário dentro de um contêiner. No entanto, muitos apps especificam um usuário não raiz diferente de `nobody` que grava no caminho de montagem do contêiner. Alguns apps especificam que o volume deve ser de propriedade do usuário raiz. Normalmente, os apps não usam o usuário raiz devido a interesses de segurança. No entanto, se o seu app requerer um usuário raiz, será possível contatar o [suporte do {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support) para obter assistência.


1.  Crie um Dockerfile em um diretório local. Este exemplo de Dockerfile está criando um usuário não raiz chamado `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    #The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Crie o script de ponto de entrada na mesma pasta local do Dockerfile. Este script de ponto de entrada de exemplo está especificando `/mnt/myvol` como o caminho de montagem do volume.

    ```
    #!/bin/bash
    set -e

    #This is the mount point for the shared volume.
    #By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      #Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #For security, remove the non-root user from root user group.
      deluser $MY_USER root

      #Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    #This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  Efetue login no {{site.data.keyword.registryshort_notm}}.

    ```
    bx cr login
    ```
    {: pre}

4.  Construa a imagem localmente. Lembre-se de substituir _&lt;my_namespace&gt;_ pelo namespace de seu registro de imagens privadas. Execute `bx cr namespace-get` se precisar localizar seu namespace.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  Envie a imagem por push para o seu namespace no {{site.data.keyword.registryshort_notm}}.

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  Crie uma solicitação de volume persistente criando um arquivo de configuração `.yaml`. Esse exemplo usa uma classe de armazenamento de desempenho inferior. Execute `kubectl get storageclasses` para ver as classes de armazenamento disponíveis.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  Crie a solicitação de volume persistente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  Crie um arquivo de configuração para montar o volume e execute o pod da imagem não raiz. O caminho de montagem do volume `/mnt/myvol` corresponde ao caminho de montagem especificado no Dockerfile. Salve a configuração como um arquivo `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  Crie o pod e monte a solicitação de volume persistente em seu pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. Verifique se o volume foi montado com êxito no pod.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    O ponto de montagem é listado no campo **Montagens de volume** e o volume é listado no campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. Efetue login no pod após a execução do pod.

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. Visualize permissões de seu caminho de montagem do volume.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    Essa saída mostra que a raiz possui permissões de leitura, gravação e execução no caminho de montagem do volume `mnt/myvol/`, mas o usuário myguest não raiz tem permissão para ler e gravar na pasta `mnt/myvol/mydata`. Por causa dessas permissões atualizadas, o usuário não raiz pode agora gravar dados no volume persistente.


