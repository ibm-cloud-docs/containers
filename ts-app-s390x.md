---

copyright:
  years: 2023
lastupdated: "2023-09-12"

keywords: kubernetes

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why do my pods fail with `exec format error`?
{: #ts-app-s390x}
{: support}

[Virtual Private Cloud]{: tag-vpc} 

After creating a pod and running `kubectl logs <pod-ID> -n <namespace>` to check the log of the pod deployment, you see an error message similar to the following.
{: tsSymptoms}

```sh
standard_init_linux.go:195: exec user process caused "exec format error"
```
{: screen}


This error message indicates the container image is not compatiable with the CPU architecture of the worker nodes. For example, the container image does not supports s390x architecture.
{: tsCauses}


Make sure that you build your apps for multiple platforms, see [Multi-platform images with docker](https://docs.docker.com/build/building/multi-platform/){: external} or [podman](https://docs.podman.io/en/latest/markdown/podman-build.1.html){: external}.
{: tsResolve}


A container image has the `FROM` directive in its `Dockerfile` with a designated parent image, consider the following situations when building your container images by using the `docker buildx` command:

   * If the parent image supports `s390x` architecture, use the `--platform linux/s390x` option with the command:
      ```sh
      $docker buildx build --platform linux/s390x -t <username>/<image>:latest --push .
      ```
      {: pre}
      
   * If the parent image doesn't support s390x architecture, work with the provider of the parent image on how to support the `s390x` architecture.

After your container image is built successfully, verify the container image is compatiable with `s390x` architecture by using the command `docker inspect <username>/<image>:latest |grep Arch` and the result of this command is `"Architecture": "390x"`. 