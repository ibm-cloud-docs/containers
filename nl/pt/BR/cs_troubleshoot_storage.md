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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
 


# Resolução de problemas de armazenamento do cluster
{: #cs_troubleshoot_storage}

Ao usar o {{site.data.keyword.containerlong}}, considere estas técnicas para resolução de problemas de armazenamento em cluster.
{: shortdesc}

Se você tiver um problema mais geral, tente a [depuração do cluster](cs_troubleshoot.html).
{: tip}

## Em um cluster de múltiplas zonas, um volume persistente falha ao ser montado em um pod
{: #mz_pv_mount}

{: tsSymptoms}
Seu cluster era anteriormente um cluster de zona única com nós do trabalhador independentes que não estavam em conjuntos de trabalhadores. Você montou com êxito um persistent volume claim (PVC) que descreveu o persistent volume (PV) a ser usado para a implementação de pod de seu app. Agora que você tem conjuntos de trabalhadores e zonas incluídas em seu cluster, no entanto, o PV falha ao ser montado em um pod.

{: tsCauses}
Para clusters de múltiplas zonas, os PVs devem ter os rótulos a seguir para que os pods não tentem montar volumes em uma zona diferente.
* ` failure-domain.beta.kubernetes.io/region `
* ` failure-domain.beta.kubernetes.io/zone `

Os novos clusters com conjuntos de trabalhadores que podem abranger múltiplas zonas rotulam os PVs por padrão. Se você criou seus clusters antes de os conjuntos de trabalhadores serem introduzidos, deve-se incluir os rótulos manualmente.

{: tsResolve}
[Atualize os PVs em seu cluster com os rótulos de região e zona](cs_storage_basics.html#multizone).

<br />


## Armazenamento de arquivo: os sistemas de arquivos para nós do trabalhador mudam para somente leitura
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Você pode ver um dos sintomas a seguir:
- Quando você executa `kubectl get pods -o wide`, você vê que vários pods que estão em execução no mesmo nó do trabalhador estão presos no estado `ContainerCreating`.
- Ao executar um comando `kubectl describe`, você vê o erro a seguir na seção **Eventos**: `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
O sistema de arquivos no nó do trabalhador é somente leitura.

{: tsResolve}
1.  Faça backup de quaisquer dados que podem ser armazenados no nó do trabalhador ou em seus contêineres.
2.  Para uma correção de curto prazo para o nó do trabalhador existente, recarregue o nó do trabalhador.
    <pre class="pre"><code> ibmcloud ks worker-reload  &lt;cluster_name&gt;  &lt;worker_ID&gt; </code></pre>

Para uma correção de longo prazo, [atualize o tipo de máquina do seu conjunto de trabalhadores](cs_cluster_update.html#machine_type).

<br />



## Armazenamento de arquivo: o app falha quando um usuário não raiz possui o caminho de montagem do armazenamento de arquivo NFS
{: #nonroot}

{: tsSymptoms}
Depois de [incluir armazenamento NFS](cs_storage_file.html#app_volume_mount) em sua implementação, a implementação de seu contêiner falha. Ao recuperar os logs para seu contêiner, talvez você veja erros como "permissão de gravação" ou "não tem a permissão necessária". O pod falha e fica preso em um ciclo de recarregamento.

{: tsCauses}
Por padrão, os usuários não raiz não tem permissão de gravação no caminho de montagem do volume para armazenamento suportado por NFS. Algumas imagens comuns do app, como Jenkins e Nexus3, especificam um usuário não raiz que possui o caminho de montagem no Dockerfile. Quando você cria um contêiner por meio desse Dockerfile, a criação do contêiner falha devido a permissões insuficientes do usuário não raiz no caminho de montagem. Para conceder permissão de gravação, é possível modificar o Dockerfile para incluir temporariamente o usuário não raiz no grupo de usuários raiz antes que ele mude as permissões de caminho de montagem ou usar um contêiner de inicialização.

Se você usar um gráfico Helm para implementar a imagem, edite a implementação do Helm para usar um contêiner de inicialização.
{:tip}



{: tsResolve}
Quando você inclui um [contêiner de inicialização![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) em sua implementação, é possível fornecer a um usuário não raiz que está especificado em seu Dockerfile as permissões de gravação para o caminho de montagem do volume dentro do contêiner. O contêiner de inicialização é iniciado antes de seu contêiner de app ser iniciado. O contêiner de inicialização cria o caminho de montagem do volume dentro do contêiner, muda o caminho de montagem para ser de propriedade do usuário correto (não raiz) e fecha. Em seguida, seu contêiner de app é iniciado com o usuário não raiz que deve gravar no caminho de montagem. Como o caminho já pertence ao usuário não raiz, a gravação no caminho de montagem é bem-sucedida. Se você não deseja usar um contêiner de inicialização, é possível modificar o Dockerfile para incluir acesso de usuário não raiz no armazenamento de arquivo NFS.


Antes de iniciar: [Efetue login em sua conta. Destine a região apropriada e, se aplicável, o grupo de recursos. Configure o contexto para seu cluster](cs_cli_install.html#cs_cli_configure).

1.  Abra o Dockerfile para seu app e obtenha o ID do usuário (UID) e ID do grupo (GID) do usuário que você deseja fornecer permissão de gravação no caminho de montagem do volume. No exemplo de um Dockerfile Jenkins, as informações são:
    - UID: `1000`
    - GID: `1000`

    **Exemplo**:

    ```
    FROM openjdk:8-jdk

    RUN apt-get update &&apt-get install -y git curl &&rm -rf /var/lib/apt/lists/*

    ARG user=jenkins
    ARG group=jenkins
    ARG uid=1000
    ARG gid=1000
    ARG http_port=8080
    ARG agent_port=50000

    ENV JENKINS_HOME /var/jenkins_home
    ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
    ...
    ```
    {:screen}

2.  Inclua armazenamento persistente para seu app criando um persistent volume claim (PVC). Este exemplo usa a classe de armazenamento `ibmc-file-bronze`. Para revisar as classes de armazenamento disponíveis, execute `kubectl get storageclasses`.

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

3.  Crie o PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  Em seu arquivo de implementação `.yaml`, inclua o contêiner de inicialização. Inclua o UID e o GID que você recuperou anteriormente.

    ```
    initContainers:
    - name: initContainer # Or you can replace with any name
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Replace UID and GID with values from the Dockerfile
      volumeMounts:
      - name: volume # Or you can replace with any name
        mountPath: /mount # Must match the mount path in the args line
    ```
    {: codeblock}

    **Exemplo** para uma implementação Jenkins:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my_pod
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: jenkins
        spec:
          containers:
          - name: jenkins
            image: jenkins
            volumeMounts:
            - mountPath: /var/jenkins_home
              name: volume
          volumes:
          - name: volume
            persistentVolumeClaim:
              claimName: mypvc
          initContainers:
          - name: permissionsfix
            image: alpine:latest
            command: ["/bin/sh", "-c"]
            args:
              - chown 1000:1000 /mount;
            volumeMounts:
            - name: volume
              mountPath: /mount
    ```
    {: codeblock}

5.  Crie o pod e monte o PVC em seu pod.

    ```
    kubectl apply -f my_pod.yaml
    ```
    {: pre}

6. Verifique se o volume foi montado com êxito no pod. Anote o nome do pod e o caminho **Contêineres/Montagens**.

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **Saída de exemplo**:

    ```
    Name:		    mypod-123456789
    Namespace:	default
    ...
    Init Containers:
    ...
    Mounts:
      /mount from volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Containers:
      jenkins:
        Container ID:
        Image:		jenkins
        Image ID:
        Port:		  <none>
        State:		Waiting
          Reason:		PodInitializing
        Ready:		False
        Restart Count:	0
        Environment:	<none>
        Mounts:
          /var/jenkins_home from volume (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

7.  Efetue login no pod usando o nome do pod que você anotou anteriormente.

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. Verifique as permissões do caminho de montagem do seu contêiner. No exemplo, o caminho de montagem é `/var/jenkins_home`.

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **Saída de exemplo**:

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    Essa saída mostra que o GID e o UID de seu Dockerfile (neste exemplo, `1000` e `1000`) possuem o caminho de montagem dentro do contêiner.

<br />


## Armazenamento de arquivo: a inclusão do acesso de usuário não raiz no armazenamento persistente falha
{: #cs_storage_nonroot}

{: tsSymptoms}
Depois de [incluir acesso de usuário não raiz no armazenamento persistente](#nonroot) ou implementar um gráfico Helm com um ID do usuário não raiz especificado, o usuário não pode gravar no armazenamento montado.

{: tsCauses}
A configuração da implementação ou do gráfico Helm especifica o [contexto de segurança](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) para o `fsGroup` (ID do grupo) e `runAsUser` (ID do usuário) do pod. Atualmente, o {{site.data.keyword.containerlong_notm}} não suporta a especificação `fsGroup` e suporta somente `runAsUser` configurado como `0` (permissões raiz).

{: tsResolve}
Remova os campos `securityContext` da configuração para `fsGroup` e `runAsUser` do arquivo de configuração de imagem, implementação ou gráfico Helm e reimplemente. Se você precisa mudar a propriedade do caminho de montagem de `nobody`, [inclua o acesso de usuário não raiz](#nonroot). Depois de incluir o [initContainer não raiz](#nonroot), configure `runAsUser` no nível de contêiner, não no nível de pod.

<br />




## Armazenamento de bloco: a montagem do armazenamento de bloco existente em um pod falha devido ao sistema de arquivo errado
{: #block_filesystem}

{: tsSymptoms}
Quando você executa `kubectl describe pod <pod_name>`, você vê o erro a seguir:
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
Você tem um dispositivo de armazenamento de bloco existente que é configurado com um sistema de arquivos `XFS`. Para montar esse dispositivo em seu pod, você [criou um PV](cs_storage_block.html#existing_block) que especificou `ext4` como seu sistema de arquivos ou nenhum sistema de arquivos na seção `spec/flexVolume/fsType`. Se nenhum sistema de arquivos está definido, o PV é padronizado para `ext4`.
O PV foi criado com êxito e foi vinculado à sua instância de armazenamento de bloco existente. No entanto, quando você tenta montar o PV em seu cluster usando um PVC correspondente, o volume falha ao ser montado. Não é possível montar sua instância de armazenamento de bloco `XFS` com um sistema de arquivos `ext4` no pod.

{: tsResolve}
Atualize o sistema de arquivos no PV existente de `ext4` para `XFS`.

1. Liste os PVs existentes em seu cluster e anote o nome do PV que você usou para a sua instância de armazenamento de bloco existente.
   ```
   kubectl get pv
   ```
   {: pre}

2. Salve o yaml do PV em sua máquina local.
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. Abra o arquivo yaml e mude o `fsType` de `ext4` para `xfs`.
4. Substitua o PV em seu cluster.
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. Efetue login no pod no qual você montou o PV.
   ```
   Kubectl exec -it < pod_name> sh
   ```
   {: pre}

6. Verifique se o sistema de arquivos mudou para `XFS`.
   ```
   -th df
   ```
   {: pre}

   Saída de exemplo:
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## Armazenamento de objeto: a instalação do plug-in Helm `ibmc` do {{site.data.keyword.cos_full_notm}} falha
{: #cos_helm_fails}

{: tsSymptoms}
Quando você instala o plug-in Helm `ibmc` do {{site.data.keyword.cos_full_notm}}, a instalação falha com o erro a seguir: 
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
Quando o plug-in Helm `ibmc` está instalado, um symlink é criado do diretório `./helm/plugins/helm-ibmc` para o diretório no qual o plug-in Helm `ibmc` está localizado em seu sistema local, que está geralmente em `./ibmcloud-object-storage-plugin/helm-ibmc`. Quando você remove o plug-in Helm `ibmc` de seu sistema local ou move o diretório do plug-in Helm `ibmc` para um local diferente, o symlink não é removido.

{: tsResolve}
1. Remova o  {{site.data.keyword.cos_full_notm}}  Plug-in do Helm. 
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}
   
2. [ Instale o  {{site.data.keyword.cos_full_notm}} ](cs_storage_cos.html#install_cos). 

<br />


## Armazenamento de objeto: a criação de PVC ou pod falha porque o segredo do Kubernetes não é localizado
{: #cos_secret_access_fails}

{: tsSymptoms}
Quando você cria seu PVC ou implementa um pod que monta o PVC, a criação ou a implementação falha. 

- Mensagem de erro de exemplo para uma falha de criação de PVC: 
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- Mensagem de erro de exemplo para uma falha de criação do pod: 
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}
  
{: tsCauses}
O segredo do Kubernetes no qual você armazena suas credenciais de serviço do {{site.data.keyword.cos_full_notm}}, o PVC e o pod não estão todos no mesmo namespace do Kubernetes. Quando o segredo é implementado em um namespace diferente de seu PVC ou pod, o segredo não pode ser acessado. 

{: tsResolve}
1. Liste os segredos em seu cluster e revise o namespace do Kubernetes no qual o segredo do Kubernetes para sua instância de serviço do {{site.data.keyword.cos_full_notm}} é criado. O segredo deve mostrar `ibm/ibmc-s3fs` como o **Tipo**. 
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}
   
2. Verifique seu arquivo de configuração YAML quanto a seu PVC e pod para verificar se você usou o mesmo namespace. Se você desejar implementar um pod em um namespace diferente daquele em que seu segredo existe, [crie outro segredo](cs_storage_cos.html#create_cos_secret) no namespace desejado. 
   
3. Crie o PVC ou implemente o pod no namespace desejado. 

<br />


## Armazenamento de objeto: a criação de PVC falha devido a credenciais erradas ou acesso negado
{: #cred_failure}

{: tsSymptoms}
Ao criar o PVC, você vê uma mensagem de erro semelhante a uma das seguintes: 

```
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```
AccessDenied: Access Denied status code: 403 
```
{: screen}

```
CredentialsEndpointError: falha ao carregar credenciais
```
{: screen}

{: tsCauses}
As credenciais de serviço do {{site.data.keyword.cos_full_notm}} que você usa para acessar a instância de serviço podem estar erradas ou permitir acesso somente leitura para seu bucket.

{: tsResolve}
1. Na navegação na página de detalhes do serviço, clique em **Credenciais de serviço**.
2. Localize suas credenciais e, em seguida, clique em **Visualizar credenciais**. 
3. Verifique se você usa o **access_key_id** e o **secret_access_key** corretos em seu segredo do Kubernetes. Se não, atualize seu segredo do Kubernetes. 
   1. Obtenha o YAML que você usou para criar o segredo. 
      ```
      kubectl get secret < secret_name> -o yaml
      ```
      {: pre}
      
   2. Atualize o  ** access_key_id **  e  ** secret_access_key **. 
   3. Atualize o segredo. 
      ```
      kubectl aplicar -f secret.yaml
      ```
      {: pre}
      
4. Na seção **iam_role_crn**, verifique se você tem a função `Writer` ou `Manager`. Se você não tem a função correta, deve-se [criar novas credenciais de serviço do {{site.data.keyword.cos_full_notm}} com a permissão correta](cs_storage_cos.html#create_cos_service). Em seguida, atualize seu segredo existente ou [crie um novo segredo](cs_storage_cos.html#create_cos_secret) com suas novas credenciais de serviço. 

<br />


## Armazenamento de objeto: não é possível acessar um bucket existente

{: tsSymptoms}
Quando você cria o PVC, o bucket no {{site.data.keyword.cos_full_notm}} não pode ser acessado. Você vê uma mensagem de erro semelhante à seguinte: 

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
Você pode ter usado a classe de armazenamento errada para acessar seu bucket existente ou tentou acessar um bucket não criado. 

{: tsResolve}
1. No [painel do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://console.bluemix.net/dashboard/apps), selecione sua instância de serviço do {{site.data.keyword.cos_full_notm}}. 
2. Selecione  ** Buckets **. 
3. Revise as informações de **Classe** e **Localização** para o seu bucket existente. 
4. Escolha a  [ classe de armazenamento ](cs_storage_cos.html#storageclass_reference) apropriada. 

<br />


## Armazenamento de objeto: falha ao acessar arquivos com um usuário não raiz
{: #cos_nonroot_access}

{: tsSymptoms}
Você transferiu por upload arquivos para a sua instância de serviço do {{site.data.keyword.cos_full_notm}} usando a GUI ou a API de REST. Quando você tenta acessar esses arquivos com um usuário não raiz definido com `runAsUser` em sua implementação de app, o acesso aos arquivos é negado. 

{: tsCauses}
No Linux, um arquivo ou um diretório tem 3 grupos de acesso: `Owner`, `Group` e `Other`. Ao fazer upload de um arquivo para o {{site.data.keyword.cos_full_notm}} usando a GUI ou a API de REST, as permissões para o `Owner`, `Group` e `Other` são removidas. A permissão de cada arquivo é semelhante à seguinte: 

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

Ao fazer upload de um arquivo usando o plug-in {{site.data.keyword.cos_full_notm}}, as permissões para o arquivo são preservadas e não mudam. 

{: tsResolve}
Para acessar o arquivo com um usuário não raiz, o usuário não raiz deve ter permissões de leitura e gravação para o arquivo. Mudar a permissão em um arquivo como parte de sua implementação do pod requer uma operação de gravação. O {{site.data.keyword.cos_full_notm}}  não foi projetado para cargas de trabalho de gravação. A atualização de permissões durante a implementação do pod pode evitar que seu pod entre em um estado `Running`. 

Para resolver esse problema, antes de montar o PVC em seu pod de app, crie outro pod para configurar a permissão correta para o usuário não raiz. 

1. Verifique as permissões de seus arquivos em seu bucket. 
   1. Crie um arquivo de configuração para seu pod `test-permission` e nomeie o arquivo como `test-permission.yaml`. 
      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: test-permission
      spec:
        containers:
        - name: test-permission
          image: nginx
          volumeMounts:
          - name: cos-vol
            mountPath: /test
        volumes:
        - name: cos-vol
          persistentVolumeClaim:
            claimName: <pvc_name>
      ```
      {: codeblock}
        
   2. Crie o pod  ` test-permission ` . 
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}
      
   3. Efetue login em seu pod. 
      ```
      kubectl exec test-permission-permission -it bash
      ```
      {: pre}
   
   4. Navegue para o caminho de montagem e liste as permissões para seus arquivos. 
      ```
      cd test & & ls -al
      ```
      {: pre}
      
      Saída de exemplo: 
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}
      
2. Exclua o pod. 
   ```
   kubectl delete pod test-permission
   ```
   {: pre}
      
3. Crie um arquivo de configuração para o pod que você usar para corrigir as permissões de seus arquivos e nomeie-o como `fix-permission.yaml`. 
   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: fix-permission 
     namespace: <namespace>
   spec:
     containers:
     - name: fix-permission
       image: busybox
       command: ['sh', '-c']
       args: ['chown -R <nonroot_userID> <mount_path>/*; find <mount_path>/ -type d -print -exec chmod u=+rwx,g=+rx {} \;']
       volumeMounts:
       - mountPath: "<mount_path>"
         name: cos-volume
     volumes:
     - name: cos-volume
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}
    
3. Crie o pod  ` fix-permission ` . 
   ```
   kubectl aplicar -f fix-permission.yaml
   ```
   {: pre}
   
4. Espere o pod entrar em um estado `Completed`.  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. Exclua o pod `fix-permission`. 
   ```
   kubectl delete pod fix-permission
   ```
   {: pre} 
   
5. Recrie o pod `test-permission` que você usou anteriormente para verificar as permissões. 
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}
   
5. Verifique se as permissões para seus arquivos estão atualizadas. 
   1. Efetue login em seu pod. 
      ```
      kubectl exec test-permission-permission -it bash
      ```
      {: pre}
   
   2. Navegue para o caminho de montagem e liste as permissões para seus arquivos. 
      ```
      cd test & & ls -al
      ```
      {: pre}

      Saída de exemplo: 
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}
      
6. Exclua o pod  ` test-permission ` . 
   ```
   kubectl delete pod test-permission
   ```
   {: pre}
   
7. Monte o PVC para o app com o usuário não raiz. 

   **Importante:** defina o usuário não raiz como `runAsUser` sem configurar `fsGroup` em seu YAML de implementação ao mesmo tempo. Configurar o `fsGroup` aciona o plug-in do {{site.data.keyword.cos_full_notm}} para atualizar as permissões de grupo para todos os arquivos em um depósito quando o pod é implementado. A atualização das permissões é uma operação de gravação e pode evitar que seu pod entre em um estado `Running`. 

Depois de configurar as permissões de arquivo corretas em sua instância de serviço do {{site.data.keyword.cos_full_notm}}, não faça upload de arquivos usando a GUI ou a API de REST. Use o plug-in do {{site.data.keyword.cos_full_notm}} para incluir arquivos em sua instância de serviço. 
{: tip}

<br />




## Obtendo ajuda e suporte
{: #ts_getting_help}

Ainda está tendo problemas com o seu cluster?
{: shortdesc}

-  No terminal, você é notificado quando atualizações para a CLI `ibmcloud` e plug-ins estão disponíveis. Certifique-se de manter sua CLI atualizada para que seja possível usar todos os comandos e sinalizações disponíveis.

-   Para ver se o {{site.data.keyword.Bluemix_notm}} está disponível, [verifique a página de status do {{site.data.keyword.Bluemix_notm}} ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/bluemix/support/#status).
-   Poste uma pergunta no [{{site.data.keyword.containerlong_notm}} Slack ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://ibm-container-service.slack.com).

    Se você não estiver usando um IBMid para a sua conta do {{site.data.keyword.Bluemix_notm}}, [solicite um convite](https://bxcs-slack-invite.mybluemix.net/) para essa Folga.
    {: tip}
-   Revise os fóruns para ver se outros usuários tiveram o mesmo problema. Ao usar os fóruns para fazer uma pergunta, marque sua pergunta para que ela seja vista pelas equipes de desenvolvimento do {{site.data.keyword.Bluemix_notm}}.

    -   Se você tiver questões técnicas sobre como desenvolver ou implementar clusters ou apps com o {{site.data.keyword.containerlong_notm}}, poste sua pergunta no [Stack Overflow ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo") ](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e identifique-a com `ibm-cloud`, `kubernetes` e `containers`.
    -   Para perguntas sobre o serviço e instruções de introdução, use o fórum do [IBM Developer Answers ![Ícone de link externo](../icons/launch-glyph.svg "Ícone de link externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Inclua as tags `ibm-cloud` e `containers`.
    Consulte [Obtendo ajuda](/docs/get-support/howtogetsupport.html#using-avatar) para obter mais detalhes sobre o uso dos fóruns.

-   Entre em contato com o Suporte IBM abrindo um chamado. Para saber como abrir um chamado de suporte IBM ou sobre os níveis de suporte e as severidades de chamado, veja [Entrando em contato com o suporte](/docs/get-support/howtogetsupport.html#getting-customer-support).

{: tip}
Ao relatar um problema, inclua o ID do cluster. Para obter o ID do seu cluster, execute `ibmcloud ks clusters`.

